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

ActiveRecord::Schema.define(:version => 20110104050741) do

  create_table "awards", :force => true do |t|
    t.string   "name"
    t.boolean  "one_per_scout"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "awards", ["name"], :name => "award_by_name", :unique => true

  create_table "badger_configs", :force => true do |t|
    t.string   "login"
    t.string   "hashed_password"
    t.string   "admin_login"
    t.string   "hashed_admin_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "court_of_honors", :force => true do |t|
    t.string   "name"
    t.date     "date"
    t.boolean  "eagle"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "court_of_honors", ["date"], :name => "coh_by_date", :unique => true
  add_index "court_of_honors", ["name"], :name => "coh_by_name", :unique => true

  create_table "merit_badges", :force => true do |t|
    t.string   "name"
    t.boolean  "eagle_required"
    t.integer  "group_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "merit_badges", ["name"], :name => "mb_by_name", :unique => true

  create_table "outings", :force => true do |t|
    t.string   "name"
    t.date     "date"
    t.integer  "nights_of_camping", :default => 1
    t.boolean  "long_term_camp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "outings", ["name"], :name => "outing_by_name", :unique => true

  create_table "ranks", :force => true do |t|
    t.string   "name"
    t.integer  "ordinal"
    t.integer  "num_merit_badges",   :default => 0
    t.integer  "num_eagle_required", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ranks", ["name"], :name => "rank_by_name", :unique => true
  add_index "ranks", ["ordinal"], :name => "rank_by_ordinal", :unique => true

  create_table "scouts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthday"
    t.boolean  "active",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
