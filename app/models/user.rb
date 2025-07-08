class User < ApplicationRecord
  has_secure_password
  validates :username, uniqueness: true
  has_many :reviews, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :favourite_products, through: :favourites, source: :product
  has_one :cart
  has_many :orders

end
