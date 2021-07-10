# frozen_string_literal: true
class Document < ApplicationRecord
  #Assosications
  belongs_to :task

  #Validation
  has_attached_file :attachment, 
    path: "documents/:id/:style/:filename", 
    default_url: "",
    storage: :s3,
    s3_credentials: {
      access_key_id: ENV['AWS_ACCESS_KEY'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      bucket: ENV['AWS_S3_BUCKET_NAME']
    },
    s3_region: "us-east-2",
    s3_protocol: 'https',
    s3_host_name: "s3-us-east-2.amazonaws.com"
    validates_attachment_content_type :attachment, 
    content_type: [
      "application/pdf",
      "application/vnd.ms-excel",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      "application/msword",
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
      "application/vnd.ms-powerpoint",
      "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    ]
end