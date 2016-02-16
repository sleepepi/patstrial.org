# frozen_string_literal: true

require 'test_helper'

# Test user registration notification emails
class UserMailerTest < ActionMailer::TestCase
  test 'notify system admin email' do
    pending = users(:pending)
    admin = users(:admin)

    # Send the email, then test that it got queued
    email = UserMailer.notify_system_admin(admin, pending).deliver_now
    assert !ActionMailer::Base.deliveries.empty?

    # Test the body of the sent email contains what we expect it to
    assert_equal [admin.email], email.to
    assert_equal "#{pending.name} Signed Up", email.subject
    assert_match /#{pending.name} \[#{pending.email}\] signed up for an account\./, email.encoded
  end

  test 'status approved email' do
    viewer = users(:viewer)

    # Send the email, then test that it got queued
    email = UserMailer.status_approved(viewer).deliver_now
    assert !ActionMailer::Base.deliveries.empty?

    # Test the body of the sent email contains what we expect it to
    assert_equal [viewer.email], email.to
    assert_equal "#{viewer.name}'s Account Approved", email.subject
    assert_match /Your account \[#{viewer.email}\] has been approved\./, email.encoded
  end
end
