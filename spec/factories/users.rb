FactoryBot.define do
  password = 'password'
  factory :user do
    username { Faker::Internet.username[1..20] }
    password { password }
  end
end
