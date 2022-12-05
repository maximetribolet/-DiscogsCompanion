# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require 'pry'
require "open-uri"
require "nokogiri"

# User.destroy_all
# Product.destroy_all

# puts 'Creating 10 fake users...'
# 10.times do
#   user = User.new(
#     email: Faker::Internet.email,
#     password: "password",
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     country: Faker::Address.country,
#     address: Faker::Address.street_address,
#     postcode: Faker::Address.zip,
#     phone_number: Faker::PhoneNumber.cell_phone_in_e164
#   )
#   user.save!
# end
# puts 'Finished!'

# puts 'Creating 10 fake products...'
# 10.times do
#   product = Product.new(
#     user_id: 1,
#     media_format: "CDr",
#     album_title: "Sleaford Mods",
#     artist: "Sleaford Mods",
#     release_date: "2007",
#     genre: "Electronic, Rock, Pop",
#     lowest_price: 5.5,
#     image_url: "https://i.discogs.com/4ERR1-8tiMlcirbi_ZhUgSXC_vRc4bHjDineoCvyXHA/rs:fit/g:sm/q:90/h:600/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9SLTUxOTky/OTQtMTQ4NzI3NzIw/Mi05NTA1LmpwZWc.jpeg",
#     product_url: "https://www.discogs.com/release/5199294-Sleaford-Mods-Sleaford-Mods",
#     product_id: "5199294",
#     num_for_sale: 4
#   )
#   product.save!
# end



# puts 'fetching max wantlist'

# discogs_username = "raphaelvr"
url = "https://api.discogs.com/users/#{discogs_username}/wants?key=yuMTbCWYdVossTDyzxJk&secret=EICWESpDigMZdQDlHVejeAHrmLNdATxd"

# url_open = URI.open(url, "Authorization" => "OLRMaNujjApbgklkmAPtMkoGmvpDDFVZGgBUfJAr").read
# response = JSON.parse(url_open)

#   response["wants"].each do |release|
#     album_title = release["basic_information"]["title"]
#     artist = release["basic_information"]["artists"][0]["name"]
#     genre = release["basic_information"]["styles"]
#     media_format = release["basic_information"]["formats"][0]["name"]
#     release_date = release["basic_information"]["year"]
#     product_id = release["id"]
#     image_url = release["basic_information"]["cover_image"]

#     @product = Product.new(album_title: album_title, artist: artist, genre: genre, media_format: media_format, release_date: release_date, product_id: product_id, product_url: "https://www.discogs.com/release/#{product_id}", image_url: image_url, user_id:1)
#     # @product.genre = @product.genre.gsub("\", '')

#     url_release = "https://api.discogs.com/releases/#{@product.product_id}"

#     url_release_open = URI.open(url_release).read
#     url_release_response = JSON.parse(url_release_open)

#     @product.lowest_price = url_release_response["lowest_price"]
#     @product.num_for_sale = url_release_response["num_for_sale"]


#     if @product.save!
#       puts "#{@product.id} created"

#     end
#   end


# script for url product create
# user_url = 3548854
# url_product_create = "https://api.discogs.com/releases/#{user_url}"

# url_product_create_open = URI.open(url_product_create).read
# url_product_create_response = JSON.parse(url_product_create_open)

#   product = Product.new(album_title: url_product_create_response["title"],
#       artist: url_product_create_response["artists"][0]["name"],
#       genre: url_product_create_response["styles"],
#       media_format: url_product_create_response["formats"][0]["name"],
#       release_date: url_product_create_response["year"],
#       product_id: url_product_create_response["id"],
#       lowest_price: url_product_create_response["lowest_price"],
#       num_for_sale: url_product_create_response["num_for_sale"],
#       image_url: url_product_create_response["images"][0]["uri"] || url_product_create_response["images"][0]["resource_url"],
#       product_url: "https://www.discogs.com/release/#{url_product_create_response["id"]}",
#       user_id: 1)

# if product.save!
#   puts "#{product.id} created"
# end

# Parser
https://www.discogs.com/sell/list?price1=0&price2=16&artist_id=1289&ev=ab&ships_from=Germany&format=Vinyl&currency=EUR&condition=Very+Good+%28VG%29


"https://www.discogs.com/sell/list?sort=listed%2Cdesc&limit=250&price2=#{@alert.max_price}&q=5611392&format=Vinyl&condition=#{@alert.min_media_condition}&currency=EUR&ships_from=#{@alert.country}&page=1"
