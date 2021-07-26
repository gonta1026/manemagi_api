class Claim < ApplicationRecord
  has_many :shoppings
  belongs_to :user

  def set_attributes_total_price(total_price)
    attributes.merge(total_price: total_price)
  end
end