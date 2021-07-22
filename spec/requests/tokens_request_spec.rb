require 'rails_helper'

RSpec.describe 'properties', type: :request do
  subject { FactoryBot.create(:user) }
  context 'POST api/v1/properties' do
    it 'should not generate a token for unauthorized user incorrect username' do
      post '/api/v1/tokens', params: {
        user: {
          username: "#{subject.username}00",
          password: 'password'
        }
      }

      expect(response).to have_http_status(:forbidden)
    end

    it 'should not generate a token for unauthorized user incorrect password' do
      post '/api/v1/tokens', params: {
        user: {
          username: subject.username,
          password: 'password2'
        }
      }

      expect(response).to have_http_status(:forbidden)
    end

    it 'should generate authenticatioin token for valid user credentials' do
      post '/api/v1/tokens', params: {
        user: {
          username: subject.username,
          password: subject.password
        }
      }

      expect(response).to have_http_status(:created)
    end
  end
end
