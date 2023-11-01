class Api::V0::SubscriptionsController < ApplicationController
  def index 
    begin
      customer = Customer.find(params[:customer_id])
      render json: SubscriptionSerializer.new(customer.subscriptions), status: :ok
    rescue StandardError => e
      render json: ErrorSerializer.new(e).serialized_json, status: :not_found
    end
  end

  def show; end

  def create
    begin
      render json: SubscriptionSerializer.new(Subscription.create!(subscription_params)), status: :created
    rescue StandardError => e
      render json: ErrorSerializer.new(e).serialized_json, status: :unprocessable_entity
    end
  end

  def update
    begin
      render json: SubscriptionSerializer.new(Subscription.update!(subscription_params)), status: :ok
    rescue StandardError => e
      render json: ErrorSerializer.new(e).serialized_json, status: :bad_request
    end
  end
  

  private

  def subscription_params
    params.require(:subscription).permit(:customer_id, :tea_id, :title, :price, :frequency, :status)
  end
end