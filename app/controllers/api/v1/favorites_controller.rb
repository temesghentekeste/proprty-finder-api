class Api::V1::FavoritesController < ApplicationController
  before_action :set_favorite, only: %i[destroy]
  before_action :check_login, only: %i[index create destroy]
  before_action :check_owner, only: %i[destroy]

  def index
    @favorites = current_user.favorites.all
    options = { include: [:property] }
    render json: FavoriteSerializer.new(@favorites, options).serializable_hash
  end

  def create
    favorite = current_user.favorites.build(property_id: params[:property_id])

    if favorite.save
      render json: { success: 'Added to your favorite list successfully!' }, status: :created
    else
      render json: { error: favorite.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @favorite.destroy!
    head 204
  rescue StandardError
    render json: { error: 'Something went wrong, please try again!' },
           status: :unprocessable_entity
  end

  private
  def set_favorite
    @favorite = Favorite.find(params[:id])
  end

  def check_owner
    head :forbidden unless @favorite.user_id == current_user&.id
  end
end
