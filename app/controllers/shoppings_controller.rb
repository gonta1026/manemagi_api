class ShoppingsController < ApplicationController
  
  def create
    shopping = Shopping.new(post_params)
    if shopping.save
      render json: { status: 'SUCCESS', data: shopping }
    else
      render json: { status: 'ERROR', data: shopping.errors }
    end
  end

  private
  def post_params
    params.require(:shopping).permit(:price, :date, :description, :shop_id).merge(user_id: current_user.id, claim_id: nil)
    # params.require(:shopping).permit(:price, :date, :description, :shop_id).merge(user_id: current_user.id, claim_id: nil)
  end
end