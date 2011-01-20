class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.integer :subscription_id
      t.string :status
      t.date :start_date
      t.integer :amount_cents
      t.integer :interval_length
      t.string :interval_unit
      t.integer :occurences
      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
  end
end
