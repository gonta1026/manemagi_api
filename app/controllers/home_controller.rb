class HomeController < ApplicationController
  def index
    render json: { status: 'SUCCESS', data: [] }
  end
end
