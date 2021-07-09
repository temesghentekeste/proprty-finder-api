class Property < ApplicationRecord
  validates :name, :address, :description, :is_for_rent, :user_id, presence: true
  validates :monthly_price, numericality: { greater_than_or_equal_to: 0 }, presence: true
  belongs_to :user
end
