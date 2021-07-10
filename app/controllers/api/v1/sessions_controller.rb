# frozen_string_literal: true
class Api::V1::SessionsController < Api::V1::AuthenticatedController
  skip_before_action :authorize_user!, only: %i[create], raise: false

  #POST /api/v1/sign_in
  def create
    ug = UserGenerator.new
    
    begin
      ug.create_session!(sign_in_params)
    rescue UserGenerator::ParameterNotFound, UserGenerator::DuplicateError,  UserGenerator::ConfirmationError, UserGenerator::InvalidCredentials => e
      render_exception(e, 422) && return
    end
    json_response(UserSerializer.new(ug.user).serializable_hash[:data][:attributes])
  end

   #DELETE /api/v1/logout
   def logout
    ug = UserGenerator.new

    begin
      ug.destroy_session!(current_user.auth_token)
    rescue UserGenerator::ParameterNotFound, UserGenerator::DuplicateError => e
      render_exception(e, 422) && return
    end
    render json: { success: true, data: {}, errors: [] }, status: 200
  end

  # Private methods
  private
  def sign_in_params
    params.require(:user).permit(:email, :password)
  end
end