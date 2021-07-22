class User < ApplicationRecord
  has_secure_password
  has_many :properties, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true

  # def current_user(user)
  #   user
  # end
end
