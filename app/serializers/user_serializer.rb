# frozen_string_literal: true
class UserSerializer
  include JSONAPI::Serializer  
  attributes :id, :first_name, :email, :last_name,  :auth_token

  attribute :full_name do |user|
    user.full_name
  end

  attribute :avatar do |user|
    user.avatar.url
  end

end
  