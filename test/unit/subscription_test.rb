require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Subscription.new.valid?
  end
end
