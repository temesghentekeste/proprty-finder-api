class Api::V1::PropertiesController < ApplicationController
  before_action :set_property, only: %i[show update destroy]
  before_action :check_login, only: %i[create index show]
  before_action :check_owner, only: %i[update destroy]

  def index
    @properties = Property.all
   
    @properties = PropertiesRepresenter.new(@properties, current_user).attach_current_user
    render json: PropertySerializer.new(@properties).serializable_hash
  end

  def show
    options = { include: [:user] }
    render json: PropertySerializer.new(@property, options).serializable_hash
  end

  def create
    property = current_user.properties.build(property_params)

    property.current_user = current_user
    if property.save
      render json: PropertySerializer.new(property).serializable_hash, status: :created
    else
      render json: { errors: property.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @property.update(property_params)
      render json: PropertySerializer.new(@property).serializable_hash
    else
      render json: { errors: @property.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @property.destroy
    head 204
  end

  private

  def check_owner
    head :forbidden unless @property.user_id == current_user&.id
  end

  def set_property
    @property = Property.find(params[:id])
    @property.current_user = current_user
  end

  def property_params
    params.permit(%i[name address monthly_price is_for_rent description featured_image])
  end
end
