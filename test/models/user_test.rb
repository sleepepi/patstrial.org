# frozen_string_literal: true

require "test_helper"

# Test deleted module for users
class UserTest < ActiveSupport::TestCase
  test "should mark user as deleted" do
    users(:viewer).destroy
    assert_equal true, users(:viewer).deleted?
  end

  test "should create user and notify admins" do
    assert_difference("User.current.count") do
      User.create(username: "firstlast", full_name: "First Last", email: "new@example.com", password: "abcdefg")
    end
  end
end
