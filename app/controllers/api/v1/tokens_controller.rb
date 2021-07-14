class Api::V1::TokensController < ApplicationController
  def create
    @user = User.find_by_username(user_params[:username])
    if @user&.authenticate(user_params[:password])
      bybug
      render json: {
        token: JsonWebToken.encode(user_id: @user.id),
        username: @user.username
      }, status: :created
    else
      head :unauthorized
    end
  end

  private

  def user_params
    params.permit(:username, :password)
  end
end
