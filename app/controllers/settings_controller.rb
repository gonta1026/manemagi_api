class SettingsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  
  def index
    settings = Setting.all
    render json: { status: 'SUCCESS', data: settings }
  end
  
  def create
    setting = Setting.new(post_params)
    if setting.save
      render json: { status: 'SUCCESS', data: setting }
    else
      render json: { status: 'ERROR', data: setting.errors }
    end
  end  

  private
  def post_params
    params.require(:setting).permit(:is_use_line, :line_notice_token).merge(user_id: current_user.id)
  end
end
