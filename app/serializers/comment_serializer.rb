# frozen_string_literal: true
class CommentSerializer
  include JSONAPI::Serializer  

  attributes :id, :comment, :created_at

  attribute :user_name do |object|
    object.user.full_name
  end

  attribute :commentor_avatar do |user|
    object.user.avatar.url
  end
end