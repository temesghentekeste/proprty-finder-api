class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :check_login, only: %i[index show]

  def index
    users = User.all
    render json: UserSerializer.new(users).serializable_hash, status: :ok
  end

  def show
    options = { include: [:properties] }
    # current_user.properties.each do |property|
    #   property.current_user = current_user
    # end
    attach_current_user
    render json: UserSerializer.new(@current_user, options).serializable_hash, status: :ok
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: UserSerializer.new(user).serializable_hash, status: :created
    else
      render json: { error: 'Something went wrong, please try again!' }, status: :unprocessable_entity
    end
  end

  def dashboard
    options = { include: [:properties] }
    current_user.properties.each do |property|
      property.current_user = current_user
    end

    render json: UserSerializer.new(current_user, options).serializable_hash, status: :ok
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
