require 'rails_helper'

RSpec.describe 'favorites', type: :request do
  before(:all) do
    @user = FactoryBot.create(:user)
    @property = FactoryBot.create(:property)
    @favorite = FactoryBot.create(:favorite)
  end

  favorite_params = { property_id: Property.last.id }
  context 'GET api/v1/favorites' do
    it 'should forbid getting all favorites for unathenticated user' do
      get '/api/v1/favorites'
      expect(response).to have_http_status(:forbidden)
    end

    it 'should get all favorites for athenticated user' do
      get '/api/v1/favorites', headers: { Authorization: JsonWebToken.encode(user_id: User.first.id) }
      expect(response).to have_http_status(:ok)
    end

    it 'should have valid json format' do
      get '/api/v1/favorites', headers: { Authorization: JsonWebToken.encode(user_id: User.first.id) }
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body, symbolize_names: true)
      actual = json_response.dig(:data, 0, :type)
      expected = 'favorite'
      expect(actual).to eq(expected)
    end
  end

  context 'POST api/v1/favorites' do
    it 'should not create favorite when there is no logged in user' do
      post '/api/v1/favorites', params: favorite_params

      expect(response).to have_http_status(:forbidden)
    end

    it 'should create favorite when there is logged in user' do
      post '/api/v1/favorites', params: favorite_params, headers: { Authorization:
        JsonWebToken.encode(user_id: User.last.id) }

      expect(response).to have_http_status(:created)
    end

    it 'should increast favorite count by 1 when created' do
      count = Favorite.all.size

      post '/api/v1/favorites', params: favorite_params, headers: { Authorization:
        JsonWebToken.encode(user_id: User.last.id) }

      expect(response).to have_http_status(:created)
      expect(Favorite.all.size).to eq(count + 1)
    end

    it 'should return valid json when favorite property is created' do
      post '/api/v1/favorites', params: favorite_params, headers: { Authorization:
        JsonWebToken.encode(user_id: User.last.id) }

      expect(response).to have_http_status(:created)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response).to eq({
                                    success: 'Added to your favorite list successfully!'
                                  })
    end
  end
end
