class ClaimsController < ApplicationController
  require "./app/utils/format_date"
  before_action :authenticate_user!, only: [:index, :new, :create, :update, :destroy, :shoppings,]

  def index
    claims = current_user.claims.order(created_at: "DESC")
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
    shoppings = current_user.shoppings.where(claim_id: nil).order(date: "DESC")
    render json: { status: 'success', data: shoppings }
  end
  
  def create
    shoppings = Shopping.find(params[:shopping_ids])
    post_merge_shoppings = post_params.merge(shoppings: shoppings)
    claim = Claim.new(post_merge_shoppings)
    if !claim.is_line_noticed && claim.is_line_notice
      claim.is_line_noticed = true
    end
    @setting = Setting.new
    if claim.save
      shopping_prices = shoppings.map do | shopping |
        shopping.price
      end
      claim_date = FormatDate::yyyy_mm_dd_wd(claim[:created_at])
      if claim.is_line_notice
        # NOTE Lineの通知
        @setting.claim_line_notice(
          shoppings,
          claim_date,
          shopping_prices.sum,
          claim[:description],
          current_user.setting.line_notice_token
        )
      end
      render json: { status: 'success', data: claim }
    else
      render json: { status: 'error', data: claim.errors }
    end
  end

  def update  
    claim = current_user.claims.find(params[:id])
    if !claim.is_receipt_line_noticed && claim.is_line_notice
      claim.is_receipt_line_noticed = true
    end
    if claim.update(update_params)
      if claim.is_line_notice
        updated_at = FormatDate::yyyy_mm_dd_wd(claim[:updated_at])
        shopping_prices = claim.shoppings.map do | shopping |
          shopping.price
        end
        @setting = Setting.new
        @setting.claim_receipt_line_notice(
          updated_at,
          shopping_prices.sum,
          current_user.setting.line_notice_token
        )
      end
      render json: { status: 'success', data: claim }
    else
      render json: { status: 'error', data: claim.errors }
    end
  end

  def destroy
    # binding.pry
    claim = current_user.claims.find(params[:id])
    shopping_prices = claim.shoppings.map do | shopping |
      shopping.price
    end
    if claim.destroy
      if params["is_line_notice"]
        @setting = Setting.new
        @setting.delete_claim_line_notice(
          shopping_prices.sum,
          current_user.setting.line_notice_token
        )
      end
      render json: { status: 'success', data: claim }
    else
      render json: { status: 'error', data: claim.errors }
    end
  end

  # 請求に紐づく買い物一覧画面
  def shoppings
    claim = Claim.find(params[:id])
    shoppings = claim.shoppings.order(date: "DESC")
    render json: { status: 'success', data: shoppings }
  end

  private
  def post_params
    params.require(:claim).permit(:is_line_notice).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:claim).permit(:is_receipt, :is_line_notice)
  end
 
  def delete_params
    params.require(:claim).permit(:is_line_notice)
  end
end