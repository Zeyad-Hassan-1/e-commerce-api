class Api::V1::OrdersController < ApplicationController
  before_action :authorized

  def index
    orders = current_user.orders.includes(order_items: :product)
    render json: orders, include: { order_items: { include: :product } }
  end

  def create
    cart = current_user.cart

    if cart.cart_items.empty?
      return render json: { error: "Cart is empty" }, status: :unprocessable_entity
    end

    order = current_user.orders.build

    cart.cart_items.each do |item|
      order.order_items.build(
        product: item.product,
        quantity: item.quantity
      )
    end

    if order.save
      cart.cart_items.destroy_all
      OrderMailer.with(order: order).confirmation_email.deliver_now
      render json: order, include: { order_items: { include: :product } }, status: :created
    else
      render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
