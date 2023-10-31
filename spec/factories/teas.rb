FactoryBot.define do
  factory :tea do
    name { Faker::Tea.variety }
    description { Faker::Tea.type }
    brew_temp { "180-105 Degrees" }
    brew_time { "1-2 minutes" }
  end
end
