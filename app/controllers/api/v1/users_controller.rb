class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :check_login, only: %i[index show]

  def index
    users = User.all
    render json: UserSerializer.new(users).serializable_hash, status: :ok
  end

  def show
    options = { include: [:properties] }

    attach_current_user
    render json: UserSerializer.new(@current_user, options).serializable_hash, status: :ok
  end

  def create
    user = User.new(user_params)

    existing_user = User.find_by(username: user_params[:username])

    if existing_user
      render json: { error: 'Username already exists, please try a diffrent username' }, status: :unprocessable_entity
      return
    end

    if user.save
      render json: {
        message: 'Account created successfully!',
        user: UserSerializer.new(user).serializable_hash
      },
             status: :created
    else
      render json: { errors: 'Try a different username!' }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def attach_current_user
    @current_user.properties = PropertiesRepresenter.new(current_user.properties, current_user).attach_current_user
  end
end
