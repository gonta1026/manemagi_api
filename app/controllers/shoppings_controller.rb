class ShoppingsController < ApplicationController
  require "./app/utils/format_date"
  before_action :authenticate_user!, only: [:index, :create, :show, :edit, :update]

  def index
    order_date =  { date: "ASC" } # TODO ここの順番は後にフロンドのリクエストのよって並び替えの対象を変更できるようにするかもしれない。
    shoppings = current_user.shoppings.order(order_date)
    render json: { status: 'success', data: shoppings }
  end
  
  def create
    shopping = Shopping.new(post_params)
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
    
    @shopping = current_user.shoppings.find(params[:id])    
    if @shopping.update(post_params)
      render json: { status: 'success', data: @shopping }
    else
      render json: { status: 'error', data: @shopping.errors }
    end
  end

  private
  def post_params
    params.require(:shopping).permit(:price, :date, :description, :is_line_notice, :shop_id).merge(user_id: current_user.id, claim_id: nil)
  end
end