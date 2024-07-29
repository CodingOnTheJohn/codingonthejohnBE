require "rails_helper"

RSpec.describe "Oauth", type: :request do
  before do
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
      uid: '123545',
      info: {
        nickname: 'mockuser',
        email: 'mockuser@example.com'
      },
      credentials: {
        token: 'mock_token',
        secret: 'mock_secret'
      }
    })
  end

  describe "GET /auth/github/callback" do
    it "Creates a new user with github" do
      get "/api/v1/auth/github"
      follow_redirect!
      expect(response).to have_http_status(:ok)

      user = User.last

      expect(user.uid).to eq("123456")
      expect(user.email).to eq("test@test.com")
    end
  end
end