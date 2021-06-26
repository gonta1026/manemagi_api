class HomeController < ApplicationController
  def index
    render json: { status: 'SUCCESS', message: 'SUCCESS' }
  end
end
