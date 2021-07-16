module PropertyHelper
  def featured_image_url(property)
    property.image_url
  end

  def favorite_checker(property)
    property.favorite?
  end
end

class PropertySerializer
  include FastJsonapi::ObjectSerializer
  extend PropertyHelper

  set_type :property

  attributes :name, :address, :monthly_price, :description, :is_for_rent

  attribute :featured_image do |property|
    featured_image_url(property)
  end

  attribute :is_favorite do |property|
    favorite_checker(property)
  end
  belongs_to :user
end
