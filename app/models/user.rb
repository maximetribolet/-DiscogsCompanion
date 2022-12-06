require 'open-uri'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  NATIONS = ["Afghanistan","Albania","Algeria","Andorra", "Angola","Anguilla","Antigua &amp; Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia &amp; Herzegovina","Botswana","Brazil","British Virgin Islands","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Cape Verde","Cayman Islands","Chad","Chile","China","Colombia","Congo","Cook Islands","Costa Rica","Cote D Ivoire","Croatia","Cruise Ship","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Estonia","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Polynesia","French West Indies","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guam","Guatemala","Guernsey","Guinea","Guinea Bissau","Guyana","Haiti","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Isle of Man","Israel","Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kuwait","Kyrgyz Republic","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macau","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Mauritania","Mauritius","Mexico","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Namibia","Nepal","Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Palestine","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russia","Rwanda","Saint Pierre &amp; Miquelon","Samoa","San Marino","Satellite","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","South Africa","South Korea","Spain","Sri Lanka","St Kitts &amp; Nevis","St Lucia","St Vincent","St. Lucia","Sudan","Suriname","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Timor L'Este","Togo","Tonga","Trinidad &amp; Tobago","Tunisia","Turkey","Turkmenistan","Turks &amp; Caicos","Uganda","Ukraine","United Arab Emirates","United Kingdom","Uruguay","Uzbekistan","Venezuela","Vietnam","Virgin Islands (US)","Yemen","Zambia","Zimbabwe"]

  has_many :products
  has_many :alerts
  has_many :matches, through: :products
  # validates :discogs_username, uniqueness: true

  after_create :fetch_wishlist, if: :discogs_username_available?

  def discogs_username_available?
    !discogs_username.nil?
  end

  def trying_fetch
    begin
      fetch_wishlist
    rescue => exception

    end

  end

  def fetch_wishlist
    url = "https://api.discogs.com/users/#{discogs_username}/wants?key=yuMTbCWYdVossTDyzxJk&secret=EICWESpDigMZdQDlHVejeAHrmLNdATxd"

    url_open = URI.open(url).read
    response = JSON.parse(url_open)

    response["wants"].each do |release|
      album_title = release["basic_information"]["title"]
      artist = release["basic_information"]["artists"][0]["name"]
      genre = release["basic_information"]["styles"]
      media_format = release["basic_information"]["formats"][0]["name"]
      release_date = release["basic_information"]["year"]
      product_id = release["id"]
      image_url = release["basic_information"]["cover_image"]

      @product = Product.new(album_title: album_title, artist: artist, genre: genre, media_format: media_format, release_date: release_date, product_id: product_id, product_url: "https://www.discogs.com/release/#{product_id}", image_url: image_url, user_id: id)

      url_release = "https://api.discogs.com/releases/#{@product.product_id}"

      url_release_open = URI.open(url_release).read
      url_release_response = JSON.parse(url_release_open)

      @product.lowest_price = url_release_response["lowest_price"]
      @product.num_for_sale = url_release_response["num_for_sale"]


      @product.save!
    end
  end
end
