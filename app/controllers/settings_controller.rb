
class SettingsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    setting = current_user.setting
    user = {
      id: current_user.id,
      name: current_user.name,
      setting: { 
        is_use_line: setting.is_use_line,
        line_notice_token: setting.line_notice_token
      }
    }
    render json: { status: 'SUCCESS', data: { user: user }}
  end

  # ユーザー登録時に合わせて登録させているため一旦コメントアウト
  # def create
  #   @setting = Setting.new(post_params)
  #   if @setting.save
  #     connection = Faraday.new(Setting::NOTIFY_API_URL)
  #     res = @setting.first_line_notice(params[:line_notice_token])
  #     if res.status != 200 
  #       Setting.find(@setting.id).destroy
  #       render json: { status: 'ERROR', message: "LINEの通知に失敗しました。トークンを再度確認してください。" }
  #     else
  #       render json: { status: 'SUCCESS', data: @setting }
  #     end      
  #   else
  #     render json: { status: 'ERROR', data: @setting.errors }
  #   end
  # end  

  private
  def post_params
    params.require(:setting).permit(:is_use_line, :line_notice_token).merge(user_id: current_user.id)
  end
end
