require 'rails_helper'

RSpec.describe Subscription, type: :model do
    let(:subscription) { Subscription.create!(title: 'Monthly Tea is Fundamental', price: 9.99, frequency: 1, status: 0) }
  describe 'Associations' do
     it { should have_one :tea }
     it { should belong_to :customer }
  end

  describe 'Validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :price }
    it { should validate_presence_of :status }
    it { should validate_presence_of :frequency }

    it { should validate_numericality_of :price }
  end

  describe 'Instance Methods' do
    let(:customer) { create(:customer) }
    let(:subscription) { Subscription.create!(title: 'Monthly Tea is Fundamental', price: 9.99, frequency: 1, status: 0, customer_id: customer.id) }

    it 'exists' do
      expect(subscription).to be_a(Subscription)
    end

    it 'has title, price, frequency, and status' do
      expect(subscription.title).to eq('Monthly Tea is Fundamental')
      expect(subscription.price).to eq(9.99)
      expect(subscription.frequency).to eq('monthly')
      expect(subscription.status).to eq('active')
    end
  end
end