FactoryBot.define do
  factory :property do
    name { Faker::Commerce.product_name }
    address { Faker::Address.street_address }
    monthly_price { rand(1.0..100.0) }
    is_for_rent { true }
    description { Faker::Lorem.sentence(word_count: 3) }
    user_id { User.first.id }
  end
end
