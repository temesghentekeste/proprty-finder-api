require 'rails_helper'

RSpec.describe 'properties', type: :request do
  subject { FactoryBot.create(:user) }

  context 'POST api/v1/properties' do
    before do
      @user = FactoryBot.create(:user)
    end
    it 'should not create property when there is no logged in user' do
      post '/api/v1/properties', params: {
          name: Faker::Commerce.product_name,
          address: Faker::Address.street_address,
          monthly_price: rand(1.0..100.0),
          is_for_rent: true,
          description: Faker::Lorem.sentence(word_count: 3),
          user_id: User.first.id
      }

      expect(response).to have_http_status(:forbidden)
    end

    it 'should create property when there is logged in user' do
      post '/api/v1/properties', params: {
          name: Faker::Commerce.product_name,
          address: Faker::Address.street_address,
          monthly_price: rand(1.0..100.0),
          is_for_rent: true,
          description: Faker::Lorem.sentence(word_count: 3)
      }, headers: { Authorization:
        JsonWebToken.encode(user_id: subject.id) }

      expect(response).to have_http_status(:created)
    end
  end
end
