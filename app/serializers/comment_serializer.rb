# frozen_string_literal: true
class CommentSerializer
  include JSONAPI::Serializer  

  attribute :id
  attribute :comment
  attribute :user_name do |object|
    object.user.first_name
  end
end