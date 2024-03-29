# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_14_235325) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "shortened_urls", force: :cascade do |t|
    t.string "short_url", null: false
    t.string "long_url", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["short_url"], name: "index_shortened_urls_on_short_url", unique: true
    t.index ["user_id"], name: "index_shortened_urls_on_user_id"
  end

  create_table "tag_topics", force: :cascade do |t|
    t.string "topic", null: false
    t.index ["topic"], name: "index_tag_topics_on_topic", unique: true
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "topic_id", null: false
    t.integer "short_url_id", null: false
    t.index ["short_url_id"], name: "index_taggings_on_short_url_id"
    t.index ["topic_id"], name: "index_taggings_on_topic_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "premium", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "visits", force: :cascade do |t|
    t.integer "short_url_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["short_url_id"], name: "index_visits_on_short_url_id"
    t.index ["user_id"], name: "index_visits_on_user_id"
  end

end
