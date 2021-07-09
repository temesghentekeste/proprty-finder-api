class User < ApplicationRecord
  has_secure_password
  has_many :properties, dependent: :destroy

  validates :username, uniqueness: true
  validates :password_digest, presence: true
end
