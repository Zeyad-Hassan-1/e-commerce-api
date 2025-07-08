class Api::V1::CartItemsController < ApplicationController
  before_action :authorized

  def create
    cart = current_user.cart || current_user.create_cart
    product = Product.find_by(id: params[:product_id])

    unless product
      return render json: { error: "Product not found" }, status: :not_found
    end

    # Check if the product is already in the cart
    item = cart.cart_items.find_by(product_id: product.id)

    if item
      item.quantity += params[:quantity].to_i
    else
      item = cart.cart_items.build(product: product, quantity: params[:quantity])
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

    new_quantity = params[:quantity].to_i

    if new_quantity < 1
      return render json: { error: "Quantity must be at least 1" }, status: :unprocessable_entity
    end

    if item.update(quantity: new_quantity)
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
end
