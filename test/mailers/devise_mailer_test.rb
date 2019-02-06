# frozen_string_literal: true

require "test_helper"

# Tests links in password reset email
class DeviseMailerTest < ActionMailer::TestCase
  test "devise reset password email" do
    user = users(:viewer)
    mail = Devise::Mailer.reset_password_instructions(user, "faketoken")
    assert_equal "Reset password for your PATS Trial account", mail.subject
    assert_equal [user.email], mail.to
    assert_match(%r{#{ENV["website_url"]}/password/edit\?reset_password_token=faketoken}, mail.body.encoded)
  end
end
