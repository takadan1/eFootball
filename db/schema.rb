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

ActiveRecord::Schema[7.2].define(version: 2025_09_13_071500) do
  create_table "matches", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "result", default: 0, null: false
    t.string "opponent_formation"
    t.integer "team_style"
    t.text "notes"
    t.integer "gf_counter", default: 0, null: false
    t.integer "gf_cross", default: 0, null: false
    t.integer "gf_one_two", default: 0, null: false
    t.integer "gf_long_shot", default: 0, null: false
    t.integer "gf_dribble", default: 0, null: false
    t.integer "gf_build_up", default: 0, null: false
    t.integer "gf_accident", default: 0, null: false
    t.integer "gf_other", default: 0, null: false
    t.integer "ga_counter", default: 0, null: false
    t.integer "ga_cross", default: 0, null: false
    t.integer "ga_one_two", default: 0, null: false
    t.integer "ga_long_shot", default: 0, null: false
    t.integer "ga_dribble", default: 0, null: false
    t.integer "ga_build_up", default: 0, null: false
    t.integer "ga_accident", default: 0, null: false
    t.integer "ga_other", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_matches_on_user_id"
  end

  create_table "shares", force: :cascade do |t|
    t.string "photo"
    t.text "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "matches", "users"
end
