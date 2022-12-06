class Scraper

  def initialize(discogs_id, max_price, country)
    @discogs_id = discogs_id
    @max_price = max_price
    @country = country
  end


  def marketplace_scraper
    marketplace_request_url = "https://www.discogs.com/sell/release/#{@discogs_id}?price1=&price2=#{@max_price}&ships_from=#{@country}"
    html_file = URI.open(marketplace_request_url).read
    html_doc = Nokogiri::HTML(html_file)

    results = []

    html_doc.search(".shortcut_navigable").each do |element|

      # link to release sale page
      link_to_product = element.search(".item_description_title").attribute("href").value

      # media_condition
      media_condition = element.search('.item_condition').text.match(/\n(.*?)\n\n/)[1].strip

      # # sleeve_condition
      sleeve_condition = element.search('.item_condition').text.match(/Sleeve:\n(.*?)\n/)[1].strip

      # # seller rating
      seller_rating = element.search('.seller_info').text.match(/\d+\.\d+%/)[0].gsub("%", "")

      # #Price
      match_price = element.search('.price').text.match(/[$£€]\d+\.\d+/)[0]

      results << {sleeve_condition: sleeve_condition }
    end

    create_matches(results)
    # [{link_to_product: link_to_product }]
  end

  def create_matches(results)
    results.each do |result|
      matched_alerts = Alert.where(country: @country,
        min_sleeve_condition: set_sleeve_conditions(result[:sleeve_condition]),
        min_media_condition: set_media_conditions(result[:media_condition])
        ).where('max_price > ?', @max_price).where('? > seller_rating', result[:seller_rating])

        matched_alerts.each { |matched_alert| create_match(matched_alert, result[:link_to_product])}
    end
  end

  def create_match(matched_alert, link_to_product)
    Match.create(link_to_product: link_to_product, alert_id: matched_alert.id, product_id: matched_alert.product.id )
  end

  def set_media_conditions(media_condition)
    case media_condition
    when "Mint (M)"
      ["Mint (M)"]
    when "Near Mint (NM or M-)"
      ["Mint (M)", "Near Mint (NM or M-)"]
    when "Very Good Plus (VG+)"
      ["Mint (M)", "Near Mint (NM or M-)", "Very Good Plus (VG+)"]
    when "Very Good (VG)"
      ["Mint (M)", "Near Mint (NM or M-)", "Very Good Plus (VG+)", "Very Good (VG)"]
    when "Good Plus (G+)"
      ["Mint (M)", "Near Mint (NM or M-)", "Very Good Plus (VG+)", "Very Good (VG)", "Good Plus (G+)"]
    when "Fair (F)"
      ["Mint (M)", "Near Mint (NM or M-)", "Very Good Plus (VG+)", "Very Good (VG)", "Good Plus (G+)", "Fair (F)"]
    when "Poor (P)"
      ["Mint (M)", "Near Mint (NM or M-)", "Very Good Plus (VG+)", "Very Good (VG)", "Good Plus (G+)", "Fair (F)", "Poor (P)"]
    end
  end

  def set_sleeve_conditions(sleeve_condition)
    case sleeve_condition
    when "Mint (M)"
      ["Mint (M)"]
    when "Near Mint (NM or M-)"
      ["Mint (M)", "Near Mint (NM or M-)"]
    when "Very Good Plus (VG+)"
      ["Mint (M)", "Near Mint (NM or M-)", "Very Good Plus (VG+)"]
    when "Very Good (VG)"
      ["Mint (M)", "Near Mint (NM or M-)", "Very Good Plus (VG+)", "Very Good (VG)"]
    when "Good Plus (G+)"
      ["Mint (M)", "Near Mint (NM or M-)", "Very Good Plus (VG+)", "Very Good (VG)", "Good Plus (G+)"]
    when "Fair (F)"
      ["Mint (M)", "Near Mint (NM or M-)", "Very Good Plus (VG+)", "Very Good (VG)", "Good Plus (G+)", "Fair (F)"]
    when "Poor (P)"
      ["Mint (M)", "Near Mint (NM or M-)", "Very Good Plus (VG+)", "Very Good (VG)", "Good Plus (G+)", "Fair (F)", "Poor (P)"]
    when "Generic"
      ["Mint (M)", "Near Mint (NM or M-)", "Very Good Plus (VG+)", "Very Good (VG)", "Good Plus (G+)", "Fair (F)", "Poor (P)", "Generic"]
    end
  end
end
