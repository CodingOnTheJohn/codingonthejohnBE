class API::V1::SessionsController < ApplicationController
  def create
    if auth_hash = request.env["omniauth.auth"]
      @user = User.from_omniauth(auth_hash)
    else
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        render json: UserSerializer.new(@user), status: :ok
      else
        render json: ErrorSerializer.new({ message: 'Invalid email or password' }), status: :unauthorized
      end
    end
    render json: UserSerializer.new(@user), status: :ok
  end

  # def destroy
  #   session[:user_id] = nil
  # end
end