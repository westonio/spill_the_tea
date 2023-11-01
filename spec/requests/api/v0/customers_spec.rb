require 'rails_helper'

RSpec.describe 'Customers Endpoints', type: :request do
  describe 'GET api/v0/customers/:id/subscriptions' do
    context 'When a valid customer ID is used' do
      it "Returns the customer's subscriptions" do
        customer = create(:customer)
        teas = create_list(:tea, 4)
        sub_1 = create(:subscription, customer_id: customer.id, tea_id: teas[0].id)
        sub_2 = create(:subscription, customer_id: customer.id, tea_id: teas[1].id)
        sub_3 = create(:subscription, customer_id: customer.id, tea_id: teas[2].id)
        sub_4 = create(:subscription, customer_id: customer.id, tea_id: teas[3].id)

        get "/api/v0/customers/#{customer.id}/subscriptions"

        expect(response).to be_successful
        
        body = JSON.parse(response.body, symbolize_names: true)

        expect(body).to be_a(Hash)
        expect(body).to have_key(:data)
        expect(body[:data]).to be_an(Array)
        
        subscriptions = body[:data]
        
        subscriptions.each do |sub|
          expect(sub).to be_a(Hash)
          expect(sub.keys).to eq([:id, :type, :attributes])
          expect(sub[:id]).to be_a(String)
          expect(sub[:type]).to eq('subscription')
          expect(sub[:attributes]).to be_a(Hash)

          attributes = sub[:attributes]
          expect(attributes.keys).to eq([:title, :price, :status, :frequency, :tea_id, :customer_id])
          expect(attributes[:title]).to be_a(String)
          expect(attributes[:price]).to be_a(Float)
          expect(attributes[:status]).to be_a(String)
          expect(attributes[:frequency]).to be_a(String)
          expect(attributes[:tea_id]).to be_a(Integer)
          expect(attributes[:customer_id]).to be_a(Integer)
        end
      end
      
      it 'Returns blank array if customer has no subscriptions' do
        customer = create(:customer)
        teas = create_list(:tea, 4)

        get "/api/v0/customers/#{customer.id}/subscriptions"

        expect(response).to be_successful
        
        body = JSON.parse(response.body, symbolize_names: true)

        expect(body).to be_a(Hash)
        expect(body).to have_key(:data)
        expect(body[:data]).to be_an(Array)
        expect(body[:data]).to be_empty
      end
    end
    
   
    context 'When an invalid customer ID is used' do
      it 'returns error message and bad_request code' do
        invalid_id = 123123123123

        get "/api/v0/customers/#{invalid_id}/subscriptions"

        expect(response).to_not be_successful
        expect(response.status).to eq(404)
        
        body = JSON.parse(response.body, symbolize_names: true)

        expect(body).to be_a(Hash)
        expect(body).to have_key(:errors)
        expect(body[:errors]).to be_an(Array)

        errors = body[:errors].first

        expect(errors).to be_a(Hash)
        expect(errors).to have_key(:details)
        expect(errors[:details]).to eq("Couldn't find Customer with 'id'=123123123123")
      end
    end
  end
end