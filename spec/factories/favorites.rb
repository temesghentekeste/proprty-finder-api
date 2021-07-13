FactoryBot.define do
  factory :favorite do
    user_id { User.first.id }
    property_id { Property.first.id }
  end
end
