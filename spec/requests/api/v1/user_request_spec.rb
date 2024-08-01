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

  describe 'Get /api/v1/login' do
    it 'allows an existing user to login' do
      User.create(
        username: 'user1',
        email: 'user1@test.com',
        password: 'password',
        password_confirmation: 'password'
      )

      login_params = {
        email: "user1@test.com",
        password: "password"
      }

      get api_v1_login_path, params: { user: login_params }

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['username']).to eq('user1')
    end

    it 'returns an error if user is not found' do
      login_params = {
        email: "user1@test.com",
        password: "password"
      }

      get api_v1_login_path, params: { user: login_params }
      expect(response).to have_http_status(:not_found)
      expect(response.body).to include("User not found")
    end

    it 'returns an error if password is invalid' do
      User.create(
        username: 'user1',
        email: 'user1@test.com',
        password: 'password',
        password_confirmation: 'password'
      )

      login_params = {
        email: "user1@test.com",
        password: "passwor"
      }

      get api_v1_login_path, params: { user: login_params }

      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to include("Invalid password")
    end
  end
  describe 'POST /api/v1/github_users' do
    let(:github_user) do
      {
        user: {
          username: 'ghuser',
          email: 'ghusertest@test.com',
          password: 'password',
          uid: '123456'
        }
      }
    end
    it 'creates a new user from github oauth' do
      expect { post '/api/v1/github_users', params: github_user }.to change(User, :count).by(1)
      expect(response).to have_http_status(:ok)
    end
    it 'returns an existing user from github oauth if it already exist' do
      User.create!(github_user[:user])

      expect { post '/api/v1/github_users', params: github_user }.to_not change(User, :count)
      expect(response).to have_http_status(:ok)
    end
  end

    describe 'sad path/ error handling' do
      let(:bad_params) do
        {
          user: {
            username: 'badparamsuser',
            email: '',
            password: '2342d3g3d',
            uid: '12425'
          }
        }
      end
    it 'returns an error if user is not created' do
        post '/api/v1/github_users', params: bad_params

        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:error_object][:message]).to eq("Validation failed: Email can't be blank")
    end
  end
end
