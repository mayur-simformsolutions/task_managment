# frozen_string_literal: true
class UserSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :id, :first_name, :email, :last_name,  :auth_token

end
  