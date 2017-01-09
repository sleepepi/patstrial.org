# frozen_string_literal: true

require 'test_helper'

# Tests links in password reset email
class DeviseMailerTest < ActionMailer::TestCase
  test 'devise reset password email' do
    user = users(:viewer)
    email = Devise::Mailer.reset_password_instructions(user, 'faketoken').deliver_now
    assert !ActionMailer::Base.deliveries.empty?
    assert_equal [user.email], email.to
    assert_equal 'Reset password instructions', email.subject
    assert_match(%r{#{ENV['website_url']}/password/edit\?reset_password_token=faketoken}, email.encoded)
  end
end
