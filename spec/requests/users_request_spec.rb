require 'rails_helper'

RSpec.describe 'users', type: :request do
  describe 'POST api/v1/users' do
    context 'renders users listing view' do
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
  end
end
