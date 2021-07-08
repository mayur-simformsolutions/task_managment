# frozen_string_literal: true
class DocumentSerializer
  include JSONAPI::Serializer  

  attribute :id, :title
  attribute :attachment do |attachment|
    attachment.attachment.url
  end
end
