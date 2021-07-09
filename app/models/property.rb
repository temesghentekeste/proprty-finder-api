class Property < ApplicationRecord
  belongs_to :user
  has_one_attached :featured_image, dependent: :destroy

  validates :name, :address, :description, :is_for_rent, :user_id, presence: true
  validates :monthly_price, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :featured_image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
end
