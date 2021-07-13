FactoryBot.define do
  password = 'password'
  factory :user do
    username { Faker::Internet.username[1..20] + (User.all.size + 1).to_s }
    password { password }
  end
end
