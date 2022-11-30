class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:product_id])
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if Product.save
      redirect_to dashboard
    else
      render :new, status: :unprocessable_entity
    end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to dashboard, notice: "Product deleted"
  end

  def dashboard
    @product = Product.where(user_id: current_user)
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def product_params
    params.require(:product).permit(:media_format, :album_title, :artist, :release_date, :genre, :lowest_price, :median_price)
  end
end
