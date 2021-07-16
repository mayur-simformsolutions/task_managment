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
    open(Faker::LoremFlickr.image( search_terms: ['human']))
  rescue
    open("https://robohash.org/sitsequiquia.png?size=300x300&set=set1")
end


def document_fetcher
  open("https://innovate-documents.s3.us-east-2.amazonaws.com/document.docx")
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
 @user = User.new(
    first_name: Faker::Name.first_name, 
    last_name: Faker::Name.first_name,
    email: Faker::Internet.email,
    password: "123456789",
    avatar: image_fetcher
  )
  @user.skip_confirmation_notification! 
  @user.save!
  @user.confirm
  PaperTrail.request.whodunnit = @user.id
  15.times do |i|
      task = @user.tasks.create!(
      title: LiterateRandomizer.sentence,
      due_date: Faker::Date.in_date_period,
      description: LiterateRandomizer.paragraph, 
      user_ids: [User.order("RANDOM()").first.id].uniq,
      label_ids: [Label.order("RANDOM()").first.id, Label.order("RANDOM()").first.id, Label.order("RANDOM()").first.id].uniq,
      solicitation_ids: [Solicitation.order("RANDOM()").first.id, Solicitation.order("RANDOM()").first.id, Solicitation.order("RANDOM()").first.id].uniq
    )
    task.documents.create(title: Faker::Company.name, attachment: open("https://innovate-documents.s3.us-east-2.amazonaws.com/document.docx"))
    
    [*1..5].shuffle.first.times do |i|
      Comment.create!(
        comment: LiterateRandomizer.sentence,
        user_id: User.order("RANDOM()").limit(1).first.id,
        task_id: task.id
      )
    end
  end 
end