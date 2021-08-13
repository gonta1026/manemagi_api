class Claim < ApplicationRecord
  # レコード削除時に関連するshoppingsの外部キーをnilに更新する
  has_many :shoppings, dependent: :nullify
  belongs_to :user

  def set_attributes_total_price(total_price)
    attributes.merge(total_price: total_price)
  end
end