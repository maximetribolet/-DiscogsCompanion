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
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    country: Faker::Address.country,
    address: Faker::Address.street_address,
    postcode: Faker::Address.zip,
    phone_number: Faker::PhoneNumber.cell_phone_in_e164
  )
  user.save!
end
puts 'Finished!'

puts 'Creating 10 fake products...'
10.times do
  product = Product.new(
    user_id: 21,
    media_format: "CDr",
    album_title: "Sleaford Mods",
    artist: "Sleaford Mods",
    release_date: "2007",
    genre: "Electronic, Rock, Pop",
    lowest_price: 5.5,
    median_price: 6.5,
    image_url: "https://i.discogs.com/4ERR1-8tiMlcirbi_ZhUgSXC_vRc4bHjDineoCvyXHA/rs:fit/g:sm/q:90/h:600/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9SLTUxOTky/OTQtMTQ4NzI3NzIw/Mi05NTA1LmpwZWc.jpeg",
    product_url: "https://www.discogs.com/release/5199294-Sleaford-Mods-Sleaford-Mods"
  )
  product.save!
end
puts 'Finished!'
