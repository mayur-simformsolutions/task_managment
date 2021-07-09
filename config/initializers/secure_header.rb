# frozen_string_literal: true
SecureHeaders::Configuration.default do |config|
  config.cookies = {
    secure: true, # mark all cookies as "Secure"
    httponly: true, # mark all cookies as "HttpOnly"
    samesite: {
      lax: true # mark all cookies as SameSite=lax
    }
  }
  config.hsts = "max-age=#{1.week.to_i}"
  config.x_frame_options = "DENY"
  config.x_content_type_options = "nosniff"
  config.x_xss_protection = "1; mode=block"
  config.x_download_options = "noopen"
  config.x_permitted_cross_domain_policies = "none"
  config.referrer_policy = %w(origin-when-cross-origin strict-origin-when-cross-origin)
  config.csp = {
    default_src: %w('self'),
    font_src: %w('self' data:),
    object_src: %w('self'),
    frame_ancestors: %w('none'),
    form_action: %w('self'),
    media_src: %w('self'),
    connect_src: %w(wss:),
    img_src: %w('self' data:),
    script_src: %w('self'),
    style_src: %w('self' 'unsafe-inline')
  }
end
