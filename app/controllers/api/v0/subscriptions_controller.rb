class Api::V0::SubscriptionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ArgumentError, with: :argument_invalid

  def index 
    customer = Customer.find(params[:customer_id])
    render json: SubscriptionSerializer.new(customer.subscriptions), status: :ok
  end

  def show; end

  def create
    render json: SubscriptionSerializer.new(Subscription.create!(subscription_params)), status: :created
  end

  def update
    subscription = Subscription.find(params[:id])
    subscription.update(subscription_params)
    render json: SubscriptionSerializer.new(subscription), status: :ok
  end
  

  private

  def subscription_params
    params.require(:subscription).permit(:customer_id, :tea_id, :title, :price, :frequency, :status)
  end

  def record_not_found(error)
    render json: ErrorSerializer.new(error).serialized_json, status: :not_found
  end

  def record_invalid(error)
    render json: ErrorSerializer.new(error).serialized_json, status: :unprocessable_entity
  end

  def argument_invalid(error)
    render json: ErrorSerializer.new(error).serialized_json, status: :bad_request
  end
end