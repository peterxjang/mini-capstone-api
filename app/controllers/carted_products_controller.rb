class CartedProductsController < ApplicationController
  def index
    @carted_products = current_user.carted_products.where(status: "carted") # alternatively: CartedProduct.where(user_id: current_user.id, status: "carted")
    render :index
  end

  def create
    @carted_product = CartedProduct.create(
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity],
      status: "carted",
    )
    render :show
  end
end
