class Api::V1::CartsController < ApplicationController
  before_action :authorized

  def show
    cart = current_user.cart || current_user.create_cart
    render json: cart, include: { cart_items: { include: :product } }
  end
end
