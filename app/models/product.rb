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

  def api_scraper(release_id)

    url_product_create = "https://api.discogs.com/releases/#{release_id}?key=yuMTbCWYdVossTDyzxJk&secret=EICWESpDigMZdQDlHVejeAHrmLNdATxd"

    url_product_create_open = URI.open(url_product_create).read
    url_product_create_response = JSON.parse(url_product_create_open)

    update(album_title: url_product_create_response["title"],
          artist: url_product_create_response["artists"][0]["name"],
          genre: url_product_create_response["styles"],
          media_format: url_product_create_response["formats"][0]["name"],
          release_date: url_product_create_response["year"],
          product_id: url_product_create_response["id"],
          lowest_price: url_product_create_response["lowest_price"],
          num_for_sale: url_product_create_response["num_for_sale"],
          image_url: url_product_create_response["images"][0]["uri"] || url_product_create_response["images"][0]["resource_url"],
          product_url: "https://www.discogs.com/release/#{url_product_create_response["id"]}")
  end
end
