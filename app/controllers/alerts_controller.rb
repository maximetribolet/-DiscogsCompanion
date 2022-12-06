class AlertsController < ApplicationController
  def index
    @alerts = Alert.where(user: current_user)
    # @alert.user = current_user
  end

  def create
    @alert = Alert.new(alert_params)
    @alert.user = current_user
    # assign this alert to current user
    @alert.product = Product.find(params[:product_id])
    @alert.media_format = @alert.product.media_format
    @alert.discogs_id = @alert.product.product_id
    if @alert.save!
      redirect_to products_path, notice: "alert created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @alert = Alert.find(params[:id])
    @alert.update!
    redirect_to dashboard
  end

  private

  def set_alert
    @alert = Product.find(params[:alert.product_id])
  end

  def alert_params
    params.require(:alert).permit(:min_media_condition, :min_sleeve_condition, :country, :max_price, :auto_buy,
                                  :alert_duration_days, :seller_rating, :product_id)
  end
end
