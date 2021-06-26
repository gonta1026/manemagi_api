class Claim < ApplicationRecord
  has_many :shoppings
  belongs_to :user
end