class ShoppingsController < ApplicationController
  require "./app/utils/format_date"
  before_action :authenticate_user!, only: [:index, :create]

  def index
    shoppings = Shopping.all
    render json: { status: 'SUCCESS', data: shoppings }
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
      render json: { status: 'SUCCESS', data: shopping }
    else
      render json: { status: 'ERROR', data: shopping.errors }
    end
  end

  private
  def post_params
    params.require(:shopping).permit(:price, :date, :description, :is_line_notice, :shop_id).merge(user_id: current_user.id, claim_id: nil)
  end
end