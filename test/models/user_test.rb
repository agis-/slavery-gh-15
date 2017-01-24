require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "foo" do
    User.create!

    assert_equal 1, User.count # succeeds
    assert_equal 1, User.on_slave.count # fails

    User.connection.commit_db_transaction
    assert_equal 1, User.on_slave.count # succeeds
  end
end
