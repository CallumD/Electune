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

ActiveRecord::Schema.define(version: 20161120205302) do

  create_table "albums", force: :cascade do |t|
    t.string   "name"
    t.datetime "release_date"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "albums", ["link"], name: "index_albums_on_link", unique: true

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artists", ["link"], name: "index_artists_on_link", unique: true

  create_table "performers", force: :cascade do |t|
    t.integer  "song_id"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "performers", ["artist_id"], name: "index_performers_on_artist_id"
  add_index "performers", ["song_id"], name: "index_performers_on_song_id"

  create_table "playlist_items", force: :cascade do |t|
    t.integer "votes"
    t.integer "user_id"
    t.integer "song_id"
    t.integer "playlist_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string   "name"
    t.datetime "start_time"
    t.boolean  "first_play"
  end

  create_table "songs", force: :cascade do |t|
    t.string   "link"
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "length",                  precision: 8, scale: 3
    t.string   "name",       limit: 1000
  end

  add_index "songs", ["link"], name: "index_songs_on_link", unique: true

  create_table "upvotements", force: :cascade do |t|
    t.integer  "upvoter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "playlist_item_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

  create_table "vetoments", force: :cascade do |t|
    t.integer  "vetoer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "playlist_item_id"
  end

end
