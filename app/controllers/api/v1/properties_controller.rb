class Api::V1::PropertiesController < ApplicationController
  before_action :check_login, only: [:create]
  def index
    @properties = Property.all

    render json: { properties: @properties }
  end

  def show
    @property = Property.find(params[:id])

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

  private

  def property_params
    params.permit(%i[name address monthly_price is_for_rent description featured_image])
  end
end
