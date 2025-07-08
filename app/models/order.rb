class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  before_validation :set_defaults
  before_save :calculate_total_price

  validates :status, inclusion: { in: %w[pending shipped delivered cancelled] }

  def set_defaults
    self.status ||= "pending"
  end

  def calculate_total_price
    self.total_price = order_items.to_a.sum { |item| item.quantity * item.product.price }
  end
end
