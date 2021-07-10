# frozen_string_literal: true
class User < ApplicationRecord
  devise :invitable,:database_authenticatable, :registerable, :validatable, :confirmable

  #Assosications
  has_many :tasks, class_name: :Task, foreign_key: :creator_id, dependent: :destroy
  has_many :task_assignees, dependent: :destroy
  has_many :comments, dependent: :destroy

  #Validations
  validates_presence_of :email, :first_name
  has_attached_file :avatar, 
    styles: { medium: "300x300>", thumb: "100x100>" },
    path: "users/:id/:style/:filename", 
    default_url: "",
    storage: :s3,
    s3_credentials: {
      access_key_id: ENV['AWS_ACCESS_KEY'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      bucket: ENV['AWS_USER_BUCKET_NAME']
    },
    s3_region: "us-east-2",
    s3_protocol: 'https',
    s3_host_name: "s3-us-east-2.amazonaws.com"
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  
  # @return [String] returns combined string
  def full_name
    first_name.to_s + ' ' + last_name.to_s
  end
end
