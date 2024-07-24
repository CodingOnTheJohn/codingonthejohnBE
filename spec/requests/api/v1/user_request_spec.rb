require 'rails_helper'

RSpec.describe 'User API', type: :request do
  describe 'POST /api/v1/users' do
    it 'creates a new user' do
      user_params = {
        username: 'user1',
        email: 'user1@test.com',
        password: 'password',
        password_confirmation: 'password'
      }

      post api_v1_users_path, params: { user: user_params }
      expect(response).to have_http_status(:created)

      user = User.last
      expect(user.username).to eq('user1')
    end

    it 'returns an error if user is not created' do
      user_params = {
        username: 'user1',
        email: ''
      }

      post api_v1_users_path, params: { user: user_params }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET /api/v1/user/:id' do
    it 'returns a user' do
      user = User.create(
        username: 'user1',
        email: 'user1@test.com',
        password: 'password',
        password_confirmation: 'password'
      )

      get api_v1_user_path(user.id)
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['username']).to eq(user.username)
    end

    it 'returns an error if user is not found' do
      get '/api/v1/users/1'

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include("Couldn't find User with 'id'=1")
    end
  end
end
