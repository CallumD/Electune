class RenameSongssToPlaylistItems < ActiveRecord::Migration
  def up
    drop_table :songs
    create_table :playlist_items do |t|
      t.integer :votes
      t.string :playlist_id
    end
  end

  def down
    drop_table :playlist_items
    create_table :songs do |t|
      t.integer :votes
      t.string :playlist_id
    end
  end
end
