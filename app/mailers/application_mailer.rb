# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "PATS Trial <#{ActionMailer::Base.smtp_settings[:email]}>"
  add_template_helper(ApplicationHelper)
  layout 'mailer'

  protected

  def setup_email
    # attachments.inline['patstrial-logo.png'] = File.read('app/assets/images/patstrial-logo.png') rescue nil
  end
end
