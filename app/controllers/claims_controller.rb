class ClaimsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :update, :shoppings]

  def index
    claims = current_user.claims
    build_claims = claims.map do | claim |
      total_price = 0
      claim.shoppings.each do | shopping |
        total_price += shopping.price
      end
      claim.set_attributes_total_price(total_price)
    end
    render json: { status: 'success', data: build_claims }
  end

  def new
    shoppings = current_user.shoppings.where(claim_id: nil)   
    render json: { status: 'success', data: shoppings }
  end
  
  def create
    shoppings = Shopping.find(params[:shopping_ids])
    post_merge_shoppings = post_params.merge(shoppings: shoppings)
    claims = Claim.new(post_merge_shoppings)
    if claims.save
      render json: { status: 'success', data: claims }
    else
      render json: { status: 'error', data: claims.errors }
    end
  end

  def update  
    @claim = current_user.claims.find(params[:id])    
    if @claim.update(update_params)
      render json: { status: 'success', data: @claim }
    else
      render json: { status: 'error', data: @claim.errors }
    end
  end

  # 請求に紐づく買い物一覧画面
  def shoppings
    claim = Claim.find(params[:id])
    shoppings = claim.shoppings
    render json: { status: 'success', data: shoppings }
  end
  
  private
  def post_params
    params.require(:claim).permit(:is_line_notice).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:claim).permit(:is_get_claim)
  end
end