class Api::V1::TokensController < ApplicationController
  def create
    @user = User.find_by_username(user_params[:username])
    if @user&.authenticate(user_params[:password])
      render json: {
        token: JsonWebToken.encode(user_id: @user.id),
        username: @user.username
      }
    else
      head :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
