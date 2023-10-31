class Subscription < ApplicationRecord
  validates_presence_of :title,
                        :price,
                        :price,
                        :status,
                        :frequency

  validates_numericality_of :price

  belongs_to :customer
  belongs_to :tea
 
  enum status: [:active, :paused, :canceled]
  enum frequency: [:weekly, :monthly, :quarterly, :annually]
end
