require 'rails_helper'

RSpec.describe 'properties', type: :request do
  subject { FactoryBot.create(:user) }
  property_params = {
    name: Faker::Commerce.product_name,
    address: Faker::Address.street_address,
    monthly_price: rand(1.0..100.0),
    is_for_rent: true,
    description: Faker::Lorem.sentence(word_count: 3)
  }

  context 'POST api/v1/properties' do
    before do
      @user = FactoryBot.create(:user)
    end
    it 'should not create property when there is no logged in user' do
      post '/api/v1/properties', params: property_params

      expect(response).to have_http_status(:forbidden)
    end

    it 'should create property when there is logged in user' do
      post '/api/v1/properties', params: property_params, headers: { Authorization:
        JsonWebToken.encode(user_id: subject.id) }

      expect(response).to have_http_status(:created)
    end

    it 'should rerurn valid json response when property is created' do
      post '/api/v1/properties', params: property_params, headers: { Authorization:
        JsonWebToken.encode(user_id: subject.id) }

      expect(response).to have_http_status(:created)

      json_response = JSON.parse(response.body, symbolize_names: true)
      name = json_response.dig(:data, :attributes, :name)
      expect(name).to eq(Property.last.name)
    end
  end
end
