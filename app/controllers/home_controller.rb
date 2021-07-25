class HomeController < ApplicationController
  def index
    render json: { status: 'success', message: '成功' }
  end
end
