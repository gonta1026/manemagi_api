members = ["otsuka", "nono", "syun", "fukada", "uirou", "test"]
members.each do |member|
  user = User.create(
    name: "#{member}",
    email: "#{member}@example.com",
    password: "11111111",
    password_confirmation: "11111111"
  )

  Setting.create(
    is_use_line: false,
    line_notice_token: nil,
    user_id: user.id
  )
  
  shop = Shop.create(
    name: "その他",
    description: "あまり行かない店舗の場合に使用してください。",
    user_id: user.id
  )
  
  shoppings = []
  5.times do |n|
    shopping = Shopping.create(
      price: 1000 * (n + 1),
      date: "2021-07-0#{(n + 1)}",
      description: "説明",
      is_line_notice: false,
      shop_id: shop.id,
      user_id: user.id
    )
    shoppings.push(shopping)
  end
  
  claim = Claim.create(
    is_line_notice: false,
    user_id: user.id,
    shoppings: shoppings
  )
end
