class OrdersController < ApplicationController
  before_action :authenticate_user

  def index
    @orders = current_user.orders
    render :index
  end

  def create
    carted_products = current_user.carted_products.where(status: "carted")
    calculated_subtotal = 0
    index = 0
    while index < carted_products.length
      carted_product = carted_products[index]
      calculated_subtotal += carted_product.quantity * carted_product.product.price
      index += 1
    end
    calculated_tax = calculated_subtotal * 0.09
    calculated_total = calculated_subtotal + calculated_tax

    @order = Order.create(
      user_id: current_user.id,
      subtotal: calculated_subtotal,
      tax: calculated_tax,
      total: calculated_total,
    )

    index = 0
    while index < carted_products.length
      carted_product = carted_products[index]
      carted_product.update(status: "purchased", order_id: @order.id)
      index += 1
    end

    render :show
  end

  def show
    @order = current_user.orders.find_by(id: params[:id])
    render :show
  end
end
