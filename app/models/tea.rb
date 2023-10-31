class Tea < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :brew_temp,
                        :brew_time

  has_many :subscriptions
end
