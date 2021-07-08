# frozen_string_literal: true
class UserGenerator
  class ParameterNotFound < StandardError; end
  class DuplicateError < StandardError; end
  class InvalidCredentials < StandardError; end
  class ConfirmationError < StandardError; end

  attr_reader :user, :role, :platform, :session

  def generate!(params)
    # validate parameters
    raise ParameterNotFound, 'Missing email' if params[:email].blank?

    user = User.find_by(email: params[:email].downcase)
    raise DuplicateError, 'This email has exists.' if user.present?

    user = User.new(params) if user.blank?

    user.auth_token =  JsonWebTokenService.encode({ email: user.email })
    user.skip_confirmation_notification! 
    user.save!
    user.confirm
    @user = user
  end

  def create_session!(params)
    
    # validate parameters
    raise ParameterNotFound, 'Missing email' if params[:email].blank?
    raise ParameterNotFound, 'Missing password' if params[:password].blank?
    
    # validate
    user = User.find_by(email: params[:email].try(:downcase),)
    raise ParameterNotFound, 'Email does not Exist.' if !user.present?
    raise InvalidCredentials, 'Invalid Password.' unless user.valid_password?(params[:password])
    raise ConfirmationError, 'Your email address is not confirmed yet, Please confirm it.' unless user.confirmed?

    user = User.find_or_initialize_by(id: user.id)
      
    token = JsonWebTokenService.encode({ email: user.email })
    user.update(auth_token: token)

    @user = user
  end

  def destroy_session!(params)
    # validate
    user = User.find_by(auth_token: params[:auth_token])
    raise ParameterNotFound, 'User does not Exist.' if !user.present?
    
    user = User.find_or_initialize_by(id: user.id)
      
    # generate (unique) token & save
    user.auth_token = nil

    user.save!  
    @user = user
  end

  def confirmation!(params)
    # validate parameters
    raise ParameterNotFound, 'Missing confirmation token' if params[:confirmation_token].blank?

    user = User.find_by(confirmation_token: params[:confirmation_token])
    raise DuplicateError, 'Invalid confirmation token' if user.blank?

    user = User.confirm_by_token(params[:confirmation_token])
    user.confirm!
    @user = user
  end

  def send!(params, current_user)
    # validate parameters
    raise ParameterNotFound, 'Missing email address' if params[:email].blank?
    raise ParameterNotFound, 'Already registered email address.' if User.find_by_email(params[:email]).present?

    user =  User.invite!({
      email: params[:email],
      first_name: params[:first_name],
      last_name: params[:last_name]
      },current_user)

    user.delay.invite!
    @user = user
  end

  def accept_invite!(params)
    # validate parameters
    raise ParameterNotFound, 'Missing invitation token' if params[:invitation_token].blank?
    
    user = User.accept_invitation!(invitation_token: params[:invitation_token], password: params[:password])
    user.save!
    @user = user
  end

end
