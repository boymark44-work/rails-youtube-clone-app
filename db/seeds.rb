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

puts "Seeding users..."

# Create 30 random users for testing
30.times do |i|
    User.create!(
        first_name: Faker::Name.first_name,
        last_name:  Faker::Name.last_name,
        email:      Faker::Internet.unique.email, 
        password:   'password123',
        admin:      i.zero? # Make the first user as an admin for testing
    )
end

puts "✅ Created 30 users (first one is admin)"