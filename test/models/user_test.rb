require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should mark user as deleted" do
    users(:regular).destroy
    assert_equal true, users(:regular).deleted?
  end
end
