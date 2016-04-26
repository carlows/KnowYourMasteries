# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160426030814) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "champion_masteries", force: :cascade do |t|
    t.integer  "summoner_id"
    t.integer  "champion_id"
    t.integer  "champion_points"
    t.boolean  "chest_granted"
    t.string   "highest_grade"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "champion_masteries", ["champion_id"], name: "index_champion_masteries_on_champion_id", using: :btree
  add_index "champion_masteries", ["summoner_id"], name: "index_champion_masteries_on_summoner_id", using: :btree

  create_table "champions", force: :cascade do |t|
    t.integer  "champion_id"
    t.string   "name"
    t.string   "key"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "summoners", force: :cascade do |t|
    t.string   "name"
    t.integer  "summoner_id"
    t.integer  "logo_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "region"
  end

  add_index "summoners", ["name"], name: "index_summoners_on_name", using: :btree

end
