FactoryBot.define do
  factory :dealer do
    name { Faker::Name.name }
    sf_id { SecureRandom.uuid }
    category { Dealer::CATEGORIES[:point_of_sale] }
  end
end
