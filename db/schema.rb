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

ActiveRecord::Schema.define(version: 2020_12_02_152819) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "moves", force: :cascade do |t|
    t.date "moving_date"
    t.string "street_name"
    t.string "street_number"
    t.string "zip"
    t.string "city"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.float "latitude"
    t.float "longitude"
    t.index ["user_id"], name: "index_moves_on_user_id"
  end

  create_table "my_providers", force: :cascade do |t|
    t.string "identifier_value"
    t.bigint "user_id", null: false
    t.bigint "provider_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider_id"], name: "index_my_providers_on_provider_id"
    t.index ["user_id"], name: "index_my_providers_on_user_id"
  end

  create_table "pdfs", force: :cascade do |t|
    t.string "uuid"
    t.bigint "update_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["update_id"], name: "index_pdfs_on_update_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "name"
    t.string "identifier_name"
    t.string "description"
    t.string "category"
    t.string "provider_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "logo_url"
    t.string "update_method"
    t.string "api_endpoint"
    t.string "street_name"
    t.string "street_number"
    t.string "zip"
    t.string "city"
  end

  create_table "updates", force: :cascade do |t|
    t.string "update_status"
    t.bigint "provider_id", null: false
    t.bigint "move_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "id_sent"
    t.index ["move_id"], name: "index_updates_on_move_id"
    t.index ["provider_id"], name: "index_updates_on_provider_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.date "birthday"
    t.date "moving_date"
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "moves", "users"
  add_foreign_key "my_providers", "providers"
  add_foreign_key "my_providers", "users"
  add_foreign_key "pdfs", "updates"
  add_foreign_key "updates", "moves"
  add_foreign_key "updates", "providers"
end
