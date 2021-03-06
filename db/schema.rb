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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170812073727) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "line_stickers", force: :cascade do |t|
    t.integer  "stk_id"
    t.integer  "stk_pkg_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string   "en_name"
    t.string   "ch_name"
    t.json     "menu"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tra_stations", force: :cascade do |t|
    t.integer  "station_id"
    t.string   "station_name"
    t.string   "station_en_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
