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

ActiveRecord::Schema[7.0].define(version: 2022_08_15_235254) do
  create_table "albums", force: :cascade do |t|
    t.string "name"
    t.datetime "release_date"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["link"], name: "index_albums_on_link", unique: true
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["link"], name: "index_artists_on_link", unique: true
  end

  create_table "performers", force: :cascade do |t|
    t.integer "song_id"
    t.integer "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_performers_on_artist_id"
    t.index ["song_id"], name: "index_performers_on_song_id"
  end

  create_table "playlist_items", force: :cascade do |t|
    t.integer "votes"
    t.integer "user_id"
    t.integer "song_id"
    t.integer "playlist_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "name"
    t.datetime "start_time"
    t.boolean "first_play"
  end

  create_table "songs", force: :cascade do |t|
    t.string "link"
    t.integer "album_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "length", precision: 8, scale: 3
    t.string "name", limit: 1000
    t.index ["link"], name: "index_songs_on_link", unique: true
  end

  create_table "upvotements", force: :cascade do |t|
    t.integer "upvoter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "playlist_item_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "vetoments", force: :cascade do |t|
    t.integer "vetoer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "playlist_item_id"
  end

end
