class ShopsController < ApplicationController
  def create
    shop = Shop.new(post_params)
    if shop.save
      render json: { status: 'SUCCESS', data: shop }
    else
      render json: { status: 'ERROR', data: shop.errors }
    end
  end

  private
  def post_params
    params.require(:shop).permit(:name, :description).merge(user_id: current_user.id)
  end
end
