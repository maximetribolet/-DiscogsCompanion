class Product < ApplicationRecord
  include PgSearch::Model
  belongs_to :user
  has_many :matches
  has_one :alert, dependent: :destroy
  # validate :product_url, presence: true
  pg_search_scope :local_search,
                  against: [ :media_format, :album_title, :artist, :genre ],
                  associated_against: {
                    alert: [:seller_rating]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
end
