require 'open-uri'
class ProductsController < ApplicationController
  def index
    if params[:query].present?
      @products = Product.local_search(params[:query])
    else
      @products = Product.where(user: current_user)
    end
  end

  # trial

  # def alert_params
  #   params.require(:alert).permit(:min_media_condition, :min_sleeve_condition, :country, :max_price, :auto_buy,
  #                                 :alert_duration_days, :seller_rating, :product_id)
  # end

  # trial

  def show
    @product = Product.find(params[:id])
  end

  def new
  end

  def create
    data = params.dig(:scrape_release_id, :release_id).match(/\d+/)
    if data.present?
      product = Product.new
      product.user = current_user
      product.api_scraper(data[0].strip.gsub("/", ""))
      redirect_to products_path, notice: "proper url, mate"
    else
      redirect_to products_path, notice: "shitty url, mate"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, notice: "Product deleted"
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
