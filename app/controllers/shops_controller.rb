class ShopsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    shops = current_user.shops
    render json: { status: 'success', data: { shops: shops }}
  end

  def create
    shop = Shop.new(post_params)
    if shop.save
      render json: { status: 'success', data: shop }
    else
      render json: { status: 'error', data: shop.errors }
    end
  end

  private
  def post_params
    params.require(:shop).permit(:name, :description).merge(user_id: current_user.id)
  end
end
