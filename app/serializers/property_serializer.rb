module FeaturedImageHelper
  def featured_image_url(property)
    property.get_image_url
  end
end

class PropertySerializer
  include FastJsonapi::ObjectSerializer
  extend FeaturedImageHelper # mixes in your helper method as class method

  set_type :property

  attributes :name, :address, :monthly_price, :description, :is_for_rent

  attribute :featured_image do |property|
    featured_image_url(property)
  end
  belongs_to :user
end

