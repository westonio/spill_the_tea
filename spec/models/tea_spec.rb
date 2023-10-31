require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe 'Associations' do
    it { should have_many :subscriptions }
  end

  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :brew_temp }
    it { should validate_presence_of :brew_time }
  end

  describe 'Instance Methods' do
    let (:customer) { create(:customer) }
    let (:tea) { Tea.create!(name: '50 Shades of Earl Grey', description: "The best earl grey you'll ever taste.", brew_temp: '212 degrees', brew_time: '1 to 2 minutes') }
    let (:subscription) { create(:subscription, customer_id: customer.id) }
    
    it 'exists' do
      expect(tea).to be_a(Tea)
    end

    it 'has name, description, brew temp, and brew time' do
      expect(tea.name).to eq('50 Shades of Earl Grey')
      expect(tea.description).to eq("The best earl grey you'll ever taste.")
      expect(tea.brew_temp).to eq('212 degrees')
      expect(tea.brew_time).to eq('1 to 2 minutes')
    end
  end
end
