# frozen_string_literal: true

# Generic mailer class defines layout and from email address
class ApplicationMailer < ActionMailer::Base
  default from: "PATS Trial <#{ActionMailer::Base.smtp_settings[:email]}>"
  helper EmailHelper
  layout "mailer"

  protected

  def setup_email
    location = "app/assets/images/pats-logo-transparent-small.png"
    attachments.inline["patstrial-logo.png"] = File.read(location)
  rescue
    nil
  end
end
