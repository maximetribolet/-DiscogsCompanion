class AlertsController < ApplicationController
  def create
    @alert = Alert.new(alert_params)
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
    params.require(:alert).permit(:min_media_condition, :min_sleeve_condition, :country, :max_price, :auto_buy, :alert_duration_days, :seller_rating)
  end
end
