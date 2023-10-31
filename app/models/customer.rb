class Customer < ApplicationRecord
  validates_presence_of :name, 
                        :email, 
                        :address

  has_many :subscriptions
  has_many :teas, through: :subscriptions
end
