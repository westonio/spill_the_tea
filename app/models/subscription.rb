class Subscription < ApplicationRecord
  validates_presence_of :title,
                        :price,
                        :price,
                        :status,
                        :frequency

  validates_numericality_of :price

  belongs_to :customer
  belongs_to :tea
 
  enum status: [:active, :canceled]
  enum frequency: [:weekly, :monthly, :quarterly, :annually]

  validate :cannot_already_exist, on: :create
  
private
  def cannot_already_exist
    if Subscription.exists?(customer_id: customer_id, tea_id: tea_id)
      errors.add(:base, "Subscription with customer_id=#{customer.id} and tea_id=#{tea.id} already exists")
    end
  end
end
