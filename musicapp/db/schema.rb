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

ActiveRecord::Schema[7.1].define(version: 2017_04_26_012053) do
  create_table "albums", force: :cascade do |t|
    t.string "name"
    t.string "artist"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "albums_tests", force: :cascade do |t|
    t.integer "album_id"
    t.integer "test_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_albums_tests_on_album_id"
    t.index ["test_id"], name: "index_albums_tests_on_test_id"
  end

  create_table "songs_tests", force: :cascade do |t|
    t.integer "song_id"
    t.integer "test_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["song_id"], name: "index_songs_tests_on_song_id"
    t.index ["test_id"], name: "index_songs_tests_on_test_id"
  end

  create_table "tests", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_hash"
    t.integer "high_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "songs_tests", "songs"
  add_foreign_key "songs_tests", "tests"
end
