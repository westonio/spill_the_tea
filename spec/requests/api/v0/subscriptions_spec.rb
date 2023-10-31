require 'rails_helper'

RSpec.describe 'Subscriptions Endpoints', type: :request do
  describe 'POST api/v0/subscriptions' do
    let(:customer) { create(:customer) }
    let(:tea) { create(:tea) }

    context 'When valid subscription parameters are used' do
      it 'sends 201 status code and creates tea_subscription object' do
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
  end
end