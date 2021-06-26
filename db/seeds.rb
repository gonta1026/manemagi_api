user_id = 1
shop_id = 1
User.create!(
  email: "text_user@example.com",
  password: "11111111",
  password_confirmation: "11111111"
)
Shop.create!(
  name: "万台",
  description: "生鮮品がいい",
  user_id: user_id
)

2.times do |n|
  Shopping.create!(
    price: 1000,
    date: "2021-06-12 01:55:11.633042",
    description: "aaa",
    is_line_notice: false,
    shop_id: shop_id,
    user_id: user_id
  )
end

Claim.create!(
  is_line_notice: true,
  user_id: user_id
)
