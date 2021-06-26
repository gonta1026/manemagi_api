class ClaimsController < ApplicationController
  def create
    # binding.pry
    shoppings = Shopping.all #sampleとしてallにしている。
    post_merge_shoppings = post_params.merge(shoppings: shoppings)
    claims = Claim.new(post_merge_shoppings)
    if claims.save
      render json: { status: 'SUCCESS', data: claims }
    else
      render json: { status: 'ERROR', data: shopping.errors }
    end
  end

  private

  def post_params
    params.require(:claim).permit(:is_line_notice).merge(user_id: current_user.id)
  end
end