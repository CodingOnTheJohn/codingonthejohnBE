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
    render json: UserSerializer.new(@user), status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :username, :email)
  end
end
