class Product < ApplicationRecord
  belongs_to :user
  has_many :matches
  # validate :product_url, presence: true
end
