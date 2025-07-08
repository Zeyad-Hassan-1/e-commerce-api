# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

puts "Seeding products..."

20.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.sentence(word_count: 10),
    price: Faker::Commerce.price(range: 10.0..200.0),
    colors: Faker::Commerce.color.split, # returns array of one or more words
    sizes: %w[S M L XL].sample(2),
    images: [ Faker::LoremFlickr.image(size: "300x300", search_terms: [ 'product' ]) ],
    categories: [ Faker::Commerce.department(max: 2) ]
  )
end

puts "✅ Done seeding products!"

User.create!(
  username: "admin",
  password: "admin123",
  bio: "Admin user",
  admin: true
)
