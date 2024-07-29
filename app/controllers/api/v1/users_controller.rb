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

  def github
    auth = request.env['omniauth.auth']
    @user = User.find_or_create_by(uid: auth['uid']) do |uid|
      uid.username = auth['info']['nickname']
      uid.email = auth['info']['email']
      uid.password = SecureRandom.hex(10)
    end

    render json: UserSerializer.new(@user), status: :ok
  end


  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
