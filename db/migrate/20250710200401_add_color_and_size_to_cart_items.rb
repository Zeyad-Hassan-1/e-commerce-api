class AddColorAndSizeToCartItems < ActiveRecord::Migration[8.0]
  def change
    add_column :cart_items, :selected_color, :string
    add_column :cart_items, :selected_size, :string
  end
end
