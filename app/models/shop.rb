class Shop < ApplicationRecord
  belongs_to :user
  has_many :shoppings
end
