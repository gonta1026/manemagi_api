class ClaimsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create, :shoppings]

  def index
    claims = current_user.claims
    render json: { status: 'SUCCESS', data: claims }
  end
  
  def create
    shoppings = Shopping.find(params[:shopping_ids])
    post_merge_shoppings = post_params.merge(shoppings: shoppings)
    claims = Claim.new(post_merge_shoppings)
    if claims.save
      render json: { status: 'SUCCESS', data: claims }
    else
      render json: { status: 'ERROR', data: shopping.errors }
    end
  end

  def shoppings
    claim = Claim.find(params[:id])
    shoppings = claim.shoppings
    render json: { status: 'SUCCESS', data: shoppings }
  end
  private

  def post_params
    params.require(:claim).permit(:is_line_notice).merge(user_id: current_user.id)
  end
end