require 'rails_helper'

RSpec.describe 'users', type: :request do
  subject { FactoryBot.create(:user) }
  describe 'controller api endpoints' do
    context 'POST api/v1/users' do
      before do
        @user = FactoryBot.create(:user)
      end
      it 'should create user' do
        post '/api/v1/users', params: {
          user: { username: 'temesghen', password: 'password' }
        }

        expect(response).to have_http_status(:created)
      end

      it 'should not create user with taken username' do
        post '/api/v1/users', params: {
          user: { username: @user.username, password: 'password' }
        }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should not create user with invalid username' do
        post '/api/v1/users', params: {
          user: { username: '', password: 'password' }
        }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should not create user with invalid password' do
        post '/api/v1/users', params: {
          user: { username: 'temesghen200', password: '' }
        }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'GET api/v1/users' do
      it 'should forbid request with invalid token' do
        get '/api/v1/users'

        expect(response).to have_http_status(:forbidden)
      end

      it 'should return all users for request with valid token' do
        get '/api/v1/users', headers: { Authorization:
          JsonWebToken.encode(user_id: subject.id) }

        expect(response).to have_http_status(:ok)
      end
    end

    context 'GET api/v1/users/1' do
      it 'should forbid request with invalid token' do
        get "/api/v1/users/#{subject.id}"

        expect(response).to have_http_status(:forbidden)
      end

      it 'should return user for request with valid token' do
        get "/api/v1/users/#{subject.id}", headers: { Authorization:
          JsonWebToken.encode(user_id: subject.id) }

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
