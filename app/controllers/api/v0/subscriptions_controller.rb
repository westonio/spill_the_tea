class Api::V0::SubscriptionsController < ApplicationController
  def create
    render json: SubscriptionSerializer.new(Subscription.create!(subscription_params)), status: :created
  end
  
  def index; end

  def show; end

  private

  def subscription_params
    params.require(:subscription).permit(:customer_id, :tea_id, :title, :price, :frequency, :status)
  end
end