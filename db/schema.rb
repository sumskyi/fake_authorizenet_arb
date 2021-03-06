# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110120162052) do

  create_table "planned_responces", :force => true do |t|
    t.integer  "subscription_id"
    t.string   "status"
    t.string   "code"
    t.string   "text"
    t.string   "refid"
    t.date     "responce_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "subscription_id"
    t.string   "status"
    t.date     "start_date"
    t.integer  "amount_cents"
    t.integer  "interval_length"
    t.string   "interval_unit"
    t.integer  "occurences"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
