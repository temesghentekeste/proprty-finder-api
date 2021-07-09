class Api::V1::PropertiesController < ApplicationController
  before_action :set_property, only: %i[show update]
  before_action :check_login, only: %i[create update]

  def index
    @properties = Property.all

    render json: { properties: @properties }
  end

  def show
    render json: { property: @property }
  end

  def create
    property = current_user.properties.build(property_params)

    # byebug
    if property.save
      render json: { property: property }, status: :created
    else
      render json: { errors: property.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @property.update(property_params)
      render json: { property: @property }
    else
      render json: { errors: @property.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.permit(%i[name address monthly_price is_for_rent description featured_image])
  end
end
