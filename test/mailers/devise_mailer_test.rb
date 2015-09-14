require 'test_helper'

class DeviseMailerTest < ActionMailer::TestCase

  test "devise reset password email" do
    regular = users(:regular)

    email = Devise::Mailer.reset_password_instructions(regular, "faketoken").deliver_now
    assert !ActionMailer::Base.deliveries.empty?

    assert_equal [regular.email], email.to
    assert_equal "Reset password instructions", email.subject
    assert_match(/#{ENV['website_url']}\/password\/edit\?reset_password_token=faketoken/, email.encoded)
  end

end
