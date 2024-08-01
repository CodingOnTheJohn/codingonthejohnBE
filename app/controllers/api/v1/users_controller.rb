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
    user = User.find_or_initialize_by(uid: params[:user][:uid])

    if user.new_record?
      user.username = params[:user][:username]
      user.email = params[:user][:email]
      user.password = params[:user][:password]
      user.save!
    end

    render json: UserSerializer.new(user), status: :ok
  end


  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :text_preference, :phone_number)
  end
end
