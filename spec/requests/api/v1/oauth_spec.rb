require "rails_helper"

RSpec.describe "Oauth", type: :request do
  describe "GET /auth/github/callback" do
    it "it gets a user from github login" do
      stub_request(:get, "https://api.github.com/user")
        .to_return(
          status: 200,
          body: {
            id: 1,
            login: "mock_username",
            email: "mock_email@example.com"
          }.to_json,
          headers: { "Content-Type" => "application/json" }
        )
        stub_request(:post, "https://github.com/login/oauth/access_token?client_id=Ov23lidkhvjxZJDMt2ST&client_secret=59561e5b7964f64fec56d6c3a7cfb0258bf236ff&code").with(
            headers: {
            'Accept'=>'application/json',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Length'=>'0',
            'User-Agent'=>'Faraday v2.10.0'
            }).to_return(
            status: 200,
            body: { access_token: "mock_access_token" }.to_json,
            headers: { "Content-Type" => "application/json" }
        )

      get "/api/v1/auth/github/callback"


      expect(response).to have_http_status(:ok)

      user = User.last
      expect(user.provider).to eq("github")
      expect(user.uid).to eq("1")
      expect(user.username).to eq("mock_username")
      expect(user.email).to eq("mock_email@example.com")

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:data][:attributes][:username]).to eq("mock_username")
      expect(response_body[:data][:attributes][:email]).to eq("mock_email@example.com")
      
    end
  end
end