FactoryBot.define do
  factory :customer do
    name { Faker::TvShows::RuPaul.queen }
    email { Faker::Internet.email }
    address { Faker::Address.full_address }
  end
end