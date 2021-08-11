class ShoppingsController < ApplicationController
  require "./app/utils/format_date"
  before_action :authenticate_user!, only: [:index, :create, :destroy, :show, :edit, :update]

  def index
    order_date =  { date: "DESC" } # TODO ここの順番は後にフロンドのリクエストのよって並び替えの対象を変更できるようにするかもしれない。
    shoppings = current_user.shoppings.order(date: "DESC")
    render json: { status: 'success', data: shoppings }
  end
  
  def destroy
    shopping = Shopping.find(params[:id])
    if shopping.destroy
      if (params["is_line_notice"])
        shopping_date = FormatDate::yyyy_mm_dd_wd(shopping[:date])
        @setting = Setting.new
        @setting.shopping_line_notice(
          shopping_date,
          shopping[:price],
          shopping.shop.name,
          shopping[:description],
          current_user.setting.line_notice_token,
          "削除"
        )
      end
      render json: { status: 'success', data: shopping }
    else
      render json: { status: 'error', data: shopping.errors }
    end
  end
  
  def create
    shopping = Shopping.new(post_params)
    if !shopping.is_line_noticed && shopping.is_line_notice
       shopping.is_line_noticed = true
    end
    if shopping.save
      shopping_date = FormatDate::yyyy_mm_dd_wd(shopping[:date])
      @setting = Setting.new
      if shopping.is_line_notice
        # NOTE Lineの通知
        @setting.shopping_line_notice(
          shopping_date,
          shopping[:price],
          shopping.shop.name,
          shopping[:description],
          current_user.setting.line_notice_token
        )
      end
      render json: { status: 'success', data: shopping }
    else
      render json: { status: 'error', data: shopping.errors }
    end
  end

  def show
    shopping = current_user.shoppings.find(params[:id])    
    render json: { status: 'success', data: shopping }
  end
  
  def edit
    shopping = current_user.shoppings.find(params[:id])    
    render json: { status: 'success', data: shopping }
  end
  
  def update
    shopping = current_user.shoppings.find(params[:id])
    if !shopping.is_line_noticed && shopping.is_line_notice
      shopping.is_line_noticed = true
    end
    if shopping.update(post_params)
      shopping_date = FormatDate::yyyy_mm_dd_wd(shopping[:date])
      @setting = Setting.new
      if shopping.is_line_notice
        # NOTE Lineの通知
        @setting.shopping_line_notice(
          shopping_date,
          shopping[:price],
          shopping.shop.name,
          shopping[:description],
          current_user.setting.line_notice_token,
          "内容変更"
        )
      end
      render json: { status: 'success', data: shopping }
    else
      render json: { status: 'error', data: shopping.errors }
    end
  end

  private
  def post_params
    params.require(:shopping).permit(:price, :date, :description, :is_line_notice, :shop_id).merge(user_id: current_user.id, claim_id: nil)
  end
end