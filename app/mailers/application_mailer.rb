class ApplicationMailer < ActionMailer::Base
  default from: ENV["FROM_MAIL"]
  layout 'mailer'
end
