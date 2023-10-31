FactoryBot.define do
  factory :subscription do
    title { Faker::TvShows::RuPaul.quote }
    price { Faker::Number.decimal(l_digits: 2) }
    status { Faker::Number.between(from: 0, to: 2) }
    frequency { Faker::Number.between(from: 0, to: 3) }
    customer_id { nil }
  end
end
