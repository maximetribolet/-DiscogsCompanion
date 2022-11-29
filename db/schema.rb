# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_11_29_141932) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alerts", force: :cascade do |t|
    t.string "min_media_condition"
    t.string "min_sleeve_condition"
    t.string "country"
    t.string "max_price"
    t.boolean "auto_buy"
    t.integer "alert_duration_days"
    t.float "seller_rating"
    t.bigint "product_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_alerts_on_product_id"
    t.index ["user_id"], name: "index_alerts_on_user_id"
  end

  create_table "matches", force: :cascade do |t|
    t.string "status"
    t.string "link_to_product"
    t.bigint "alert_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alert_id"], name: "index_matches_on_alert_id"
    t.index ["product_id"], name: "index_matches_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "media_format"
    t.string "album_title"
    t.string "artist"
    t.string "release_date"
    t.string "genre"
    t.float "lowest_price"
    t.float "median_price"
    t.string "product_url"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "country"
    t.string "address"
    t.string "plz"
    t.string "phone_number"
    t.string "discogs_username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "alerts", "products"
  add_foreign_key "alerts", "users"
  add_foreign_key "matches", "alerts"
  add_foreign_key "matches", "products"
  add_foreign_key "products", "users"
end
