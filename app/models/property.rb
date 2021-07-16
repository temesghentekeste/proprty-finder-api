class Property < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :user
  has_one_attached :featured_image, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name, :address, :description, :is_for_rent, :user_id, presence: true
  validates :monthly_price, numericality: { greater_than_or_equal_to: 0 }, presence: true

  after_commit :add_default_image, on: %i[create update]

  def add_default_image
    return if featured_image.attached?

    featured_image.attach(
      io: File.open(Rails.root.join('assets', 'images', 'no_image_available.jpeg')),
      filename: 'no_image_available.jpg', content_type: 'image/jpg'
    )
  end

  def image_url
    url_for(featured_image)
  end

  def favorite?
    Favorite.where(user_id: user_id, property_id: id).count.positive?
  end
end
