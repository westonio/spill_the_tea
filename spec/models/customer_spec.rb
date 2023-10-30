require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'Associations' do
    it { should have_many :subscriptions }
    it { should have_many :teas }
  end
  
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :address }
  end
  
  describe 'Instance Methods' do
    let(:customer) { Customer.create!(name: 'Violet Chachki', email:'Violet.Chachki@gmail.com', address: '1234 Rainbow Road, Los Angeles, CA 90005') }
    
    it 'exists' do
      expect(customer).to be_a(Customer)
    end

    it 'has a name, email, and address' do
      expect(customer.name).to eq('Violet Chachki')
      expect(customer.email).to eq('Violet.Chachki@gmail.com')
      expect(customer.address).to eq('1234 Rainbow Road, Los Angeles, CA 90005')
    end
  end
end
