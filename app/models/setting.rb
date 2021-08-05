class Setting < ApplicationRecord
  require "./app/utils/format_date"
  belongs_to :user
  NOTIFY_API_URL = "https://notify-api.line.me/api"
 
  def first_line_notice(token, is_use_line)
    on_or_off = is_use_line ? "ON" : "OFF";
    message = "\nLINEのトークンがセットされました！\n[ライン通知設定：#{on_or_off}"
    line_notice(token, message)
  end

  def shopping_line_notice(date, price, shop_name, description, token)
    line_notice(
      token,
      "\n[買い物連絡]\n購入日： #{date}\n金額： #{price}円\n場所： #{shop_name}\n特記事項： #{description}"
    )
  end
  
  def claim_line_notice(shoppings, date, claim_price, description, token)
    shoppings_format = ""
    under_line = "-------------------------"
    shoppings.each do | shopping |
      shoppings_format += "#{under_line}\n\n購入日： #{FormatDate::yyyy_mm_dd_wd(shopping.date)}\n金額： #{shopping.price}円\n場所： #{shopping.shop.name}\n特記事項： #{shopping.description}\n"
    end
    line_notice(
      token,
      "\n[請求連絡]\n請求日： #{date}\n金額： #{claim_price}円\n特記事項： #{description}\n\n[下記より請求内訳]\n" + shoppings_format
    )
  end

  def line_token_check(token)
    connection = Faraday.new("#{NOTIFY_API_URL}/status")
    connection.headers["Authorization"] = "Bearer #{token}"
    connection.get
  end
  
  private

  def line_notice(token, message)
    connection = Faraday.new("#{NOTIFY_API_URL}/notify")
    connection.headers["Authorization"] = "Bearer #{token}"
    connection.params[:message] = message
    connection.post
  end
end
