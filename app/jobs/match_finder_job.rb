class MatchFinderJob < ApplicationJob
  queue_as :default

  def perform(discogs_id, max_price, country, currency)
    Scraper.new(discogs_id, max_price, country, currency).marketplace_scraper
  end
end
