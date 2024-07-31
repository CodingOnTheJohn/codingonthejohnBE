class Api::V1::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: UserSerializer.new(@user), status: :created
    else
      render json: ErrorSerializer.new(@user.errors), status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    if @user
      render json: UserSerializer.new(@user), status: :ok
    else
      render json: ErrorSerializer.new(@user.errors), status: :not_found
    end
  end

  def login
    user = User.find_by(email: params[:user][:email])
    if user
      if user && user.authenticate(params[:user][:password])
        render json: UserSerializer.new(user), status: :ok
      else
        render json: ErrorSerializer.new({ message: 'Invalid password' }), status: :unauthorized
      end
    else
      render json: ErrorSerializer.new({ message: 'User not found' }), status: :not_found
    end
  end

  def create_github_user
    user = User.find_or_create_by(uid: params[:user][:uid])
    user.username = params[:user][:username]
    user.email = params[:user][:email]
    user.password = params[:user][:password]
    user.save!

    render json: UserSerializer.new(user), status: :ok
  end

  # def github
  #   redirect_to "https://github.com/login/oauth/authorize?client_id=#{Rails.application.credentials.github['client_id']}&scope=user:email", allow_other_host: true
  # end

  # def github_callback
  #   code = params[:code]
  #   client_id = Rails.application.credentials.github['client_id']
  #   client_secret = Rails.application.credentials.github['client_secret']

  #   conn = Faraday.new(url: 'https://github.com', headers: { 'Accept' => 'application/json' })

  #   response = conn.post('/login/oauth/access_token') do |req|
  #     req.params['client_id'] = client_id
  #     req.params['client_secret'] = client_secret
  #     req.params['code'] = code
  #   end

  #   data = JSON.parse(response.body, symbolize_names: true)
  #   access_token = data[:access_token]

  #   conn = Faraday.new(url: 'https://api.github.com', headers: { 'Authorization': "token #{access_token}"})

  #   response = conn.get('/user')
  #   user_info = JSON.parse(response.body, symbolize_names: true)
  #   user = User.find_or_create_by(uid: user_info[:id], provider: 'github')
  #   user.username = user_info[:login]
  #   user.email = user_info[:email]
  #   user.password = SecureRandom.hex(10)
  #   user.save

  #   render json: UserSerializer.new(user), status: :ok
  # end


  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :text_preference, :phone_number)
  end
end
