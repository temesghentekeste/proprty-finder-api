class Api::V1::UsersController < ApplicationController
  def index
    users = User.all
    render json: users, status: :ok
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: { user: user }, status: :created
    else
      render json: { error: 'Something went wrong, please try again!' }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
