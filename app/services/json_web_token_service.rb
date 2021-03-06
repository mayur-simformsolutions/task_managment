# frozen_string_literal: true
class JsonWebTokenService

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode payload, Rails.application.secrets.secret_key_base, 'HS256'
  end

  # @param [string] token The User session token to validate
  # @return [Hash] True if session token match otherwise FAILED  
  def self.decode(token)
    return JWT.decode(token, Rails.application.secrets.secret_key_base, algorithm: 'HS256' )[0]
  rescue
    'FAILED'
  end

end
  