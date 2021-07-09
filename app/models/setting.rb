class Setting < ApplicationRecord
  belongs_to :user

  NOTIFY_API_URL = "https://notify-api.line.me/api/notify"
  INITIAL_LINE_MESSAGE = "LINEのTOKENがセットできました！\r\n次回から買い物や請求時にライン通知をさせることができます！"
 
  def first_line_notice(token)
    line_notice(token, INITIAL_LINE_MESSAGE)
  end
  
  def shopping_line_notice(date, price, shop_name, description)
    token = Setting.first.line_notice_token
    line_notice(
      token,
      "\n[買い物連絡]\n購入日： #{date}\n金額： #{price}円\n場所： #{shop_name}\n特記事項： #{description}"
    )
  end

  private
  def line_notice(token, message)
    connection = Faraday.new(NOTIFY_API_URL)
    connection.headers["Authorization"] = "Bearer #{token}"
    connection.params[:message] = message
    connection.post
  end
end
