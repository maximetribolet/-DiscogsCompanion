require 'open-uri'
class ProductsController < ApplicationController
  def index
    if params[:query].present?
      @products = Product.local_search(params[:query])
    else
      @products = Product.all
    end
  end
  # def index

  # end

  def show
    @product = Product.find(params[:id])
  end

  def new
  end

  def create
    # pegar a url que o usuria submited (primeiro tenta submit so' o release ID)
    # faz um fetch request pra o api, interpoland o relsead ID -> https://api.discogs.com/releases/339574
    # com o resultado do api, pegar as variaves que te interessam
    # name =
    # year =
    # ....
    # depois de pegar todas as variaveis que voce precisa, criar um novo Product -> Product.new(name: name_coming_from_api...)
    # normal if save redict...
  end

  # def create
  #   @product = Product.new(product_params)
  #   @product.user = current_user
  #   if Product.save
  #     redirect_to dashboard
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

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
