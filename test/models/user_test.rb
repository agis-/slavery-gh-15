require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "foo" do
	  assert_equal 0, User.count
	  assert_equal 0, User.on_slave.count

	  # this happens in a transaction in `master` connection (let's call it connection A)
    # but is *not* yet commited, therefore only connection `A` knows about this change
	  User.create!

	  # this succeeds since it runs in A
	  assert_equal 1, User.count

	  # this fails since it runs in another connection (let's call it `B`) which
    # has no knowledge of
	  # changes in A (since that transaction is not commited yet)
	  assert_equal 1, User.on_slave.count

	  User.connection.commit_db_transaction
	  assert_equal 1, User.on_slave.count # succeeds
  end
end
