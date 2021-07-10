# frozen_string_literal: true
class DocumentSerializer
  include JSONAPI::Serializer  

  attribute :id

  attribute :attachment do |attachment|
    attachment.attachment.url
  end

  attribute :name do |attachment|
    attachment.title
  end
end
