# frozen_string_literal: true

class User < ActiveRecord::Base
  has_one :setting
  has_many :shops
  has_many :claims
  has_many :shoppings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

end
