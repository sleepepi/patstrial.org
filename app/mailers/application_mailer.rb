# frozen_string_literal: true

# Generic mailer class defines layout and from email address
class ApplicationMailer < ActionMailer::Base
  default from: "PATS Trial <#{ActionMailer::Base.smtp_settings[:email]}>"
  add_template_helper(EmailHelper)
  layout 'mailer'

  protected

  def setup_email
    attachments.inline['patstrial-logo.png'] = File.read('app/assets/images/pats-logo-transparent-small.png')
  rescue
    nil
  end
end
