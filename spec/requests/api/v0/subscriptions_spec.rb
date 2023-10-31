require 'rails_helper'

RSpec.describe 'Subscriptions Endpoints', type: :request do
  describe 'POST api/v0/subscriptions' do
    context 'When valid subscription parameters are used' do
      it 'sends 201 status code and creates tea_subscription object' do
        customer = create(:customer) 
        tea = create(:tea) 
        headers = { 'Content-Type' => 'application/json' }
        params = { 
                  customer_id: customer.id, 
                  tea_id: tea.id,
                  title: 'Monthly Tea is Fundamental', 
                  price: 9.99, frequency: 1
                  # Status default value 0 (enum: active)
                }
        
        expect(Subscription.exists?(customer_id: customer.id, tea_id: tea.id)).to eq(false)

        post '/api/v0/subscriptions', headers: headers, params: JSON.generate(subscription: params)
        
        expect(Subscription.exists?(customer_id: customer.id, tea_id: tea.id)).to eq(true)
        expect(response).to be_successful
        expect(response.status).to eq(201)

        subscription = JSON.parse(response.body, symbolize_names: true)

        expect(subscription).to be_a(Hash)
        expect(subscription).to have_key(:data)
        expect(subscription[:data]).to be_a(Hash)

        expect(subscription[:data].keys).to eq([:id, :type, :attributes])
        expect(subscription[:data][:id]).to be_a(String)
        expect(subscription[:data][:type]).to eq("subscription")
        expect(subscription[:data][:attributes]).to be_a(Hash)
        
        attributes = subscription[:data][:attributes]
        
        expect(attributes.keys).to eq([:title, :price, :status, :frequency, :tea_id, :customer_id])
        expect(attributes[:title]).to be_a(String)
        expect(attributes[:price]).to be_a(Float)
        expect(attributes[:status]).to be_a(String)
        expect(attributes[:frequency]).to be_a(String)
        expect(attributes[:tea_id]).to be_a(Integer)
        expect(attributes[:customer_id]).to be_a(Integer)
      end
    end

    context 'When invalid customer or tea IDs are used' do
      it 'Sends error message and unprocessable entity code' do
        invalid_id = 999999999
        tea = create(:tea)
        headers = { 'content-type' => 'application/json' }
        params = {
          customer_id: invalid_id,
          tea_id: tea.id,
          title: "Quarterly tea is the bee's knees",
          price: 24.99,
          frequency: 2
        }

        post '/api/v0/subscriptions', headers: headers, params: JSON.generate(subscription: params)

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        body = JSON.parse(response.body, symbolize_names: true)

        expect(body).to be_a(Hash)
        expect(body).to have_key(:errors)
        expect(body[:errors]).to be_an(Array)

        errors = body[:errors].first

        expect(errors).to be_a(Hash)
        expect(errors).to have_key(:details)
        expect(errors[:details]).to eq('Validation failed: Customer must exist')
      end
    end

      context 'When invalid attributes are used' do
      it 'Sends error message and unprocessable entity code' do
        customer = create(:customer)
        tea = create(:tea)
        headers = { 'content-type' => 'application/json' }
        params = {
          customer_id: customer.id,
          tea_id: tea.id,
          title: nil, # No title attribute
          price: 24.99,
          frequency: 2
        }

        post '/api/v0/subscriptions', headers: headers, params: JSON.generate(subscription: params)

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        body = JSON.parse(response.body, symbolize_names: true)

        expect(body).to be_a(Hash)
        expect(body).to have_key(:errors)
        expect(body[:errors]).to be_an(Array)

        errors = body[:errors].first

        expect(errors).to be_a(Hash)
        expect(errors).to have_key(:details)
        expect(errors[:details]).to eq("Validation failed: Title can't be blank")
      end
    end
  end
end