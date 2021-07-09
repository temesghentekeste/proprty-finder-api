class Property < ApplicationRecord
  belongs_to :user
  has_one_attached :featured_image, dependent: :destroy

  validates :name, :address, :description, :is_for_rent, :user_id, presence: true
  validates :monthly_price, numericality: { greater_than_or_equal_to: 0 }, presence: true
  # validates :featured_image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']

  after_commit :add_default_image, on: %i[create update]

  def add_default_image
    unless featured_image.attached?
      featured_image.attach(
        io: File.open(Rails.root.join('assets', 'images', 'no_image_available.jpeg')),
        filename: 'no_image_available.jpg', content_type: 'image/jpg'
      )
    end
  end
end
