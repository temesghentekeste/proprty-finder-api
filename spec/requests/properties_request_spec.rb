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

    it 'should create a property with valid featured image' do
      post '/api/v1/properties', params: property_params, headers: { Authorization:
        JsonWebToken.encode(user_id: subject.id) }

      expect(response).to have_http_status(:created)

      json_response = JSON.parse(response.body, symbolize_names: true)
      featured_image_url = json_response.dig(:data, :attributes, :featured_image)
      expect(featured_image_url).to eq(Property.last.image_url)
    end
  end

  context 'GET api/v1/properties' do
    it 'should return all properties' do
      get '/api/v1/properties'

      expect(response).to have_http_status(:ok)
    end
  end

  context 'GET api/v1/properties/1' do
    it 'should return a single property' do
      @property = FactoryBot.create(:property)

      get "/api/v1/properties/#{@property.id}"

      expect(response).to have_http_status(:ok)
    end

    it 'should return correct json data' do
      @property = FactoryBot.create(:property)

      get "/api/v1/properties/#{@property.id}"

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body, symbolize_names: true)

      name = json_response.dig(:data, :attributes, :name)
      featured_image_url = json_response.dig(:data, :attributes, :featured_image)

      expect(name).to eq(@property.name)
      expect(featured_image_url).to eq(@property.image_url)
    end
  end

  context 'PUT api/v1/properties/1' do
    it 'should not update property for unauthorized user' do
      @property = FactoryBot.create(:property)

      put "/api/v1/properties/#{@property.id}"

      expect(response).to have_http_status(:forbidden)
    end

    it 'should update property for authorized user' do
      @property = FactoryBot.create(:property)

      put "/api/v1/properties/#{@property.id}", params: property_params, headers: { Authorization:
        JsonWebToken.encode(user_id: User.first.id) }

      expect(response).to have_http_status(:ok)
    end
  end
end
