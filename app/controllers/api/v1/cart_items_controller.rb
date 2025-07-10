class Api::V1::CartItemsController < ApplicationController
  before_action :authorized

  def create
    cart = current_user.cart || current_user.create_cart
    product = Product.find_by(id: cart_item_params[:product_id])

    unless product
      return render json: { error: "Product not found" }, status: :not_found
    end

    unless product.colors.include?(cart_item_params[:selected_color]) &&
           product.sizes.include?(cart_item_params[:selected_size])
      return render json: { error: "Invalid color or size" }, status: :unprocessable_entity
    end

    item = cart.cart_items.find_by(
      product_id: product.id,
      selected_color: cart_item_params[:selected_color],
      selected_size: cart_item_params[:selected_size]
    )

    if item
      item.quantity += cart_item_params[:quantity].to_i
    else
      item = cart.cart_items.build(cart_item_params)
    end

    if item.save
      render json: item, status: :created
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    item = current_user.cart.cart_items.find_by(id: params[:id])

    unless item
      return render json: { error: "Cart item not found" }, status: :not_found
    end

    new_quantity = cart_item_params[:quantity].to_i
    if new_quantity < 1
      return render json: { error: "Quantity must be at least 1" }, status: :unprocessable_entity
    end

    if cart_item_params[:selected_color] && cart_item_params[:selected_size]
      unless item.product.colors.include?(cart_item_params[:selected_color]) &&
             item.product.sizes.include?(cart_item_params[:selected_size])
        return render json: { error: "Invalid color or size" }, status: :unprocessable_entity
      end
    end

    if item.update(cart_item_params)
      render json: item
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    item = current_user.cart.cart_items.find_by(id: params[:id])

    unless item
      return render json: { error: "Cart item not found" }, status: :not_found
    end

    if item.destroy
      head :no_content
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end
  private
  def cart_item_params
    params.permit(:product_id, :quantity, :selected_color, :selected_size)
  end
end
