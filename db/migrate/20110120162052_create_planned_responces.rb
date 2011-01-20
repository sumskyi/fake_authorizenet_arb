class CreatePlannedResponces < ActiveRecord::Migration
  def self.up
    create_table :planned_responces do |t|
      t.references :subscription
      t.string :status
      t.string :code
      t.string :text
      t.string :refid
      t.date :responce_at

      t.timestamps
    end
  end

  def self.down
    drop_table :planned_responces
  end
end
