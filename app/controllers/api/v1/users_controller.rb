# frozen_string_literal: true
class Api::V1::UsersController < Api::V1::AuthenticatedController 
  
  # GET /api/users
  def index
    begin
      users = User.all
    rescue => e
      render_exception(e, 422) && return
    end
    json_response(UserSerializer.new(users).serializable_hash[:data].map {|user| user[:attributes]})
  end
end
