class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:product_id])
  end

  

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def product_params
    params.require(:product).permit(:media_format, :album_title, :artist, :release_date, :genre, :lowest_price, :median_price)
  end
end
