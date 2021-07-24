members = ["otsuka", "nono", "syun", "fukada", "uirou", "text"]
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
    name: "万台",
    description: "生鮮品がいい",
    user_id: user.id
  )
  
  shoppings = []
  5.times do |n|
    shopping = Shopping.create(
      price: 1000 * (n + 1),
      date: "2021-06-0#{(n + 1)}",
      description: "説明",
      is_line_notice: false,
      shop_id: shop.id,
      user_id: user.id
    )
    shoppings.push(shopping)
  end
  
  claim = Claim.create(
    is_line_notice: true,
    user_id: user.id,
    shoppings: shoppings
  )
  
  # shoppings.each do |shopping|
  #   shopping.update!(claim_id: claim.id)
  # end
end
