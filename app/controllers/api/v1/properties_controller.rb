class Api::V1::PropertiesController < ApplicationController
  def index
    @properties = Property.all

    render json: { properties: @properties }
  end

  def show
    @property = Property.find(params[:id])

    render json: { property: @property }
  end
end
