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
  end
end
