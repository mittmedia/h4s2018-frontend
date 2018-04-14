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

ActiveRecord::Schema.define(version: 20180414132004) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "region_subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_region_subscriptions_on_region_id"
    t.index ["user_id"], name: "index_region_subscriptions_on_user_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.integer "lantmateriet_reference_id"
    t.integer "parent_id"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lantmateriet_reference_id"], name: "index_regions_on_lantmateriet_reference_id"
    t.index ["level"], name: "index_regions_on_level"
    t.index ["parent_id"], name: "index_regions_on_parent_id"
  end

  create_table "topic_subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.string "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_topic_subscriptions_on_topic_id"
    t.index ["user_id"], name: "index_topic_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "subscription"
  end

  add_foreign_key "region_subscriptions", "regions"
  add_foreign_key "region_subscriptions", "users"
  add_foreign_key "topic_subscriptions", "users"
end
