require 'rails_helper'

RSpec.describe 'favorites', type: :request do
  context 'GET api/v1/favorites' do
    it 'should forbid getting all favorites for unathenticated user' do
      get '/api/v1/favorites'
      expect(response).to have_http_status(:forbidden)
    end

    it 'should get all favorites for athenticated user' do
      @user = FactoryBot.create(:user)

      get '/api/v1/favorites', headers: { Authorization: JsonWebToken.encode(user_id: User.first.id) }
      expect(response).to have_http_status(:ok)
    end

    it 'should have valid json format' do
      @user = FactoryBot.create(:user)
      @property = FactoryBot.create(:property)
      @favorite = FactoryBot.create(:favorite)

      get '/api/v1/favorites', headers: { Authorization: JsonWebToken.encode(user_id: User.first.id) }
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body, symbolize_names: true)
      actual = json_response.dig(:data, 0, :type)
      expected = 'favorite'
      expect(actual).to eq(expected)
    end
  end
end
