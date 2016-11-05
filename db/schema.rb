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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(version: 20_121_228_135_707) do
  create_table 'albums', force: true do |t|
    t.string   'name'
    t.datetime 'release_date'
    t.string   'spotify_link'
    t.datetime 'created_at',   null: false
    t.datetime 'updated_at',   null: false
  end

  add_index 'albums', ['spotify_link'], name: 'index_albums_on_spotify_link', unique: true

  create_table 'artists', force: true do |t|
    t.string   'name'
    t.string   'spotify_link'
    t.datetime 'created_at',   null: false
    t.datetime 'updated_at',   null: false
  end

  add_index 'artists', ['spotify_link'], name: 'index_artists_on_spotify_link', unique: true

  create_table 'performers', force: true do |t|
    t.integer  'song_id'
    t.integer  'artist_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_index 'performers', ['artist_id'], name: 'index_performers_on_artist_id'
  add_index 'performers', ['song_id'], name: 'index_performers_on_song_id'

  create_table 'playlist_items', force: true do |t|
    t.integer 'votes'
    t.integer 'user_id'
    t.integer 'song_id'
    t.integer 'playlist_id'
  end

  create_table 'playlists', force: true do |t|
    t.string   'name'
    t.datetime 'start_time'
  end

  create_table 'songs', force: true do |t|
    t.string   'spotify_link'
    t.integer  'album_id'
    t.datetime 'created_at',                                                 null: false
    t.datetime 'updated_at',                                                 null: false
    t.decimal  'length', precision: 8, scale: 3
    t.string   'name', limit: 1000
  end

  add_index 'songs', ['spotify_link'], name: 'index_songs_on_spotify_link', unique: true

  create_table 'upvotements', force: true do |t|
    t.integer  'upvoter_id'
    t.datetime 'created_at',       null: false
    t.datetime 'updated_at',       null: false
    t.integer  'playlist_item_id'
  end

  create_table 'users', force: true do |t|
    t.string   'email'
    t.datetime 'created_at',      null: false
    t.datetime 'updated_at',      null: false
    t.string   'password_digest'
  end

  create_table 'vetoments', force: true do |t|
    t.integer  'vetoer_id'
    t.datetime 'created_at',       null: false
    t.datetime 'updated_at',       null: false
    t.integer  'playlist_item_id'
  end
end
