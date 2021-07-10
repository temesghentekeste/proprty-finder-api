class PropertySerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :address, :monthly_price, :description, :is_for_rent

  belongs_to :user
end
