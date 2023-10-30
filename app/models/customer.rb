class Customer < ApplicationRecord
  validates_presence_of :name, 
                        :email, 
                        :address
end
