class AlertsController < ApplicationController
  def index
    @alert = Alert.where(user: current_user)
  end

  def create
    @alert = Alert.new(alert_params)
    @alert.user = current_user
    # assign this aletr to current user
    # normal if save flow
    if @alert.save
      redirect_to products_path, notice: "alert creted"
    else
      render new:, status: :unprocessable_entity
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
