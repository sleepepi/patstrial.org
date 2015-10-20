require 'test_helper'

# Test deleted module for users
class UserTest < ActiveSupport::TestCase
  test 'should mark user as deleted' do
    users(:viewer).destroy
    assert_equal true, users(:viewer).deleted?
  end

  test 'should create user and notify admins' do
    assert_difference('User.current.count') do
      User.create(first_name: 'New First', last_name: 'New Last', email: 'new@example.com', password: 'abcdefg', password_confirmation: 'abcdefg')
    end
  end
end
