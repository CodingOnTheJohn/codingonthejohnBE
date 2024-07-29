require "rails_helper"

RSpec.describe "Oauth", type: :request do
  let(:github_auth) do
    OmniAuth::AuthHash.new(
      provider: "github",
      uid: "123456",
      info: {
        email: "test@test.com"
      }
    )
  end
  before do
    OmniAuth.config.mock_auth[:github] = github_auth
  end

  describe "GET /auth/github/callback" do
    it "Creates a new user with github" do
      get "/api/v1/auth/github/callback"

      user = User.last

      expect(user.uid).to eq("123456")
      expect(user.email).to eq("test@test.com")
    end
  end
end