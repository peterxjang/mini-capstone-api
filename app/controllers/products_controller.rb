class ProductsController < ApplicationController
  def index
    @products = Product.all
    render :index
  end

  def create
    @product = Product.create(
      name: params[:name],
      price: params[:price],
      image_url: params[:image_url],
      description: params[:description],
    )
    render :show
  end

  def show
    @product = Product.find_by(id: params[:id])
    render :show
  end

  def update
    @product = Product.find_by(id: params[:id])
    @product.update(
      name: params[:name] || @product.name,
      price: params[:price] || @product.price,
      image_url: params[:image_url] || @product.image_url,
      description: params[:description] || @product.description,
    )
    render :show
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    @product.destroy
    render json: { message: "Product destroyed successfully!" }
  end
end
