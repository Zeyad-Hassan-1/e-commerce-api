class Product < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :cart_items
  has_many :carts, through: :cart_items

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true
end
