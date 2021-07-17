module PropertyHelper
  def featured_image_url(property)
    property.image_url
  end

  def favorite_checker(property, current_user)
    property.favorite?(current_user)
  end
end

class PropertySerializer
  @@current_user = nil
  include FastJsonapi::ObjectSerializer
  extend PropertyHelper

  set_type :property

  attributes :name, :address, :monthly_price, :description, :is_for_rent

  attribute :featured_image do |property|
    featured_image_url(property)
  end

  attribute :is_favorite do |property|
    favorite_checker(property, @@current_user)
  end

  def self.current_user(current_user)
    @@current_user = current_user
  end

  belongs_to :user
end
