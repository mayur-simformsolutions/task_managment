# frozen_string_literal: true
class Api::V1::InvitationsController < Api::V1::AuthenticatedController
  skip_before_action :authorize_user!, only: %i[accept_invitation], raise: false

  # POST /send_invitation
  def send_invitation
    ug = UserGenerator.new

    begin
      ug.send!(invite_params, @current_user)
    rescue UserGenerator::ParameterNotFound, UserGenerator::DuplicateError => e
      render_exception(e, 422) && return
    end
    render json: { success: true, data: {}, errors: [] }, status: 200
  end
  
  # POST /accept_invitation
  def accept_invitation
    ug = UserGenerator.new
  
    begin
      ug.accept_invite!(invite_params)
    rescue UserGenerator::ParameterNotFound, UserGenerator::DuplicateError => e
      render_exception(e, 422) && return
    end
    render json: { success: true, data: {}, errors: [] }, status: 200
  end

  private


  def invite_params
    params.require(:user).permit(:id, :email, :invitation_token, :first_name, :last_name, :password)
  end
end