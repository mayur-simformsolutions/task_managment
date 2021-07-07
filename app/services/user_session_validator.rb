# frozen_string_literal: true
class UserSessionValidator
  class TokenValidatorError < StandardError; end
  class ParameterNotFound < TokenValidatorError; end
  class SessionNotFound < TokenValidatorError; end
  class SessionExpired < TokenValidatorError; end
  class UserNotFound < TokenValidatorError; end

  # TTL = ENV['SESSION_TIMEOUT'].try(:to_i) || 1.year

  attr_reader :user, :session

  def validate!(token)
    # validate parameters
    raise ParameterNotFound, 'missing token' if token.blank?
    
    # validate
    user = User.find_by(auth_token: token)
    raise SessionNotFound, 'invalid session' if user.blank?
    @user = user
  end
end
