FactoryBot.define do
  factory :customer do
    name { Faker::TvShows::RuPaul.queen }
    email { Faker::Internet.free_email }
    address { Faker::Address.full_address }
  end
end