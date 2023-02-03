class OrdersController < ApplicationController
  before_action :authenticate_user

  def index
    @orders = current_user.orders
    render :index
  end

  def create
    @order = Order.create(
      user_id: current_user.id,
    )
    carted_products = current_user.carted_products.where(status: "carted")
    carted_products.update_all(status: "purchased", order_id: @order.id)
    @order.update_totals
    render :show
  end

  def show
    @order = current_user.orders.find_by(id: params[:id])
    render :show
  end
end
