# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

puts 'Creating 10 fake users...'
10.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    country: Faker::Address.country,
    address: Faker::Address.street_address,
    plz: Faker::Address.zip,
    phone_number: Faker::PhoneNumber.cell_phone_in_e164
  )
  user.save!
end
puts 'Finished!'

# puts 'Creating 20 fake products...'
# 20.times do
#   product = Product.new(
#     media_format:,
#     album_title:,
#     artist:,
#     release_date:,
#     genre:,
#     lowest_price:,
#     median_price:,
#     seller_id:,
#     product_url:
#   )
#   product.save!
# end
# puts 'Finished!'
