user = User.create!(
  email: "text_user@example.com",
  password: "11111111",
  password_confirmation: "11111111"
)
shop = Shop.create!(
  name: "万台",
  description: "生鮮品がいい",
  user_id: user.id
)

shoppings = []
2.times do |n|
  shopping = Shopping.create!(
    price: 1000,
    date: "2021-06-12 01:55:11.633042",
    description: "説明",
    is_line_notice: false,
    shop_id: shop.id,
    user_id: user.id
  )
  shoppings.push(shopping)
end

claim = Claim.create!(
  is_line_notice: true,
  user_id: user.id
)

shoppings.each do |shopping|
  shopping.update!(claim_id: claim.id)
end