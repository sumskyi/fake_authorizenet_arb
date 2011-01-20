class Subscription < ActiveRecord::Base
    attr_accessible :subscription_id, :status, :start_date, :amount_cents, :interval_length, :interval_unit, :occurences
end
