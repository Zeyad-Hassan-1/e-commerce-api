# app/models/cart_item.rb
class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  validates :quantity, numericality: { greater_than: 0 }
  validate :color_and_size_must_be_available

  private

  def color_and_size_must_be_available
    if selected_color.present? && !product.colors.include?(selected_color)
      errors.add(:selected_color, "is not available for this product")
    end

    if selected_size.present? && !product.sizes.include?(selected_size)
      errors.add(:selected_size, "is not available for this product")
    end
  end
end
