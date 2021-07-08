# frozen_string_literal: true
class UserSerializer
  include JSONAPI::Serializer  
  attributes :id, :first_name, :email, :last_name,  :auth_token

  attribute :avatar do |user|
    user.avatar.url
  end

end
  