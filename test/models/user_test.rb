require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "foo" do
    User.create!

    assert_equal 1, User.count
    assert_equal 1, User.on_slave.count # fails
  end
end
