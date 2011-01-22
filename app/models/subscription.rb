class Subscription < ActiveRecord::Base
  before_create :set_subscription

  attr_accessible :subscription_id, :status, :start_date, :amount_cents, :interval_length, :interval_unit, :occurences

  has_many  :planned_responces do
    def current
      where('responce_at = DATE(?)', DateTime.now).first
    end
  end

  # increment
  def set_subscription
    self.subscription_id = self.class.find_by_sql("SELECT MAX(subscription_id) + 1 as next_value FROM subscriptions LIMIT 1").first.next_value || 10000000
  end

  def cancel!
    self.planned_responces.current.cancel
  end

end
