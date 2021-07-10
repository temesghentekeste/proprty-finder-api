class Api::V1::FavoritesController < ApplicationController
  before_action :check_login, only: %i[index]

  def index
    @favorites = current_user.favorites.all
    options = { include: [:property] }
    render json: FavoriteSerializer.new(@favorites, options).serializable_hash
  end
end
