
class SettingsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    setting = current_user.setting
    user = {
      id: current_user.id,
      name: current_user.name,
      setting: { 
        id: setting.id,
        is_use_line: setting.is_use_line,
        line_notice_token: setting.line_notice_token
      }
    }
    render json: { status: 'success', data: user}
  end

  def update
    @setting = Setting.find(current_user.setting.id)
    if post_params[:line_notice_token].blank?
      update_setting(@setting)
      return # 処理を抜ける。
    end

    # 空でなければトークンのチェックをする。
    response = @setting.line_token_check(post_params[:line_notice_token])
    if response.status != 200
      # 設定情報のtokenをセットしたらtokenが誤ってエラーになる。
      render json: { status: 'error', data: response, message: "invalid_token" }
    else
      update_setting(@setting)
    end
  end

  private
  def post_params
    params.require(:setting).permit(:is_use_line, :line_notice_token).merge(user_id: current_user.id)
  end

  def update_setting(setting)
    if setting.update(post_params)
      # 設定情報のtokenをセットて正常の処理ができた
      render json: { status: 'success', data: setting }
    else
      # 設定情報の保存に失敗
      render json: { status: 'error', data: setting.errors }
    end
  end
end
