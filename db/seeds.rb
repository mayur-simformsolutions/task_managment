# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'

# Prepare profile image
def image_fetcher
  Faker::LoremFlickr.image( search_terms: ['face'])
  rescue
  open("https://loremflickr.com/300/300/face")
end

# Populate tables
5.times do |i|
  Label.create!(
    name: Faker::Name::label
  )
  
  Solicitation.create!(
    name:  Faker::Name::solicitation,
    description: Faker::Lorem.paragraph
  )
end

# Create users
20.times do |i|
 user = User.new(
    first_name: Faker::Name.first_name, 
    last_name: Faker::Name.first_name,
    email: Faker::Internet.email,
    password: "123456789",
    avatar: image_fetcher
  )
  user.skip_confirmation_notification! 
  user.save!
  user.confirm
  end
end