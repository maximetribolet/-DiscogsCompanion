class Product < ApplicationRecord
  belongs_to :user
  has_many :matches
  has_one :alert, dependent: :destroy
  # validate :product_url, presence: true
end
