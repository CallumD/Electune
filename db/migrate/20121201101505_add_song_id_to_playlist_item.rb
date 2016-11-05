class AddSongIdToPlaylistItem < ActiveRecord::Migration
  def up
    add_column :playlist_items, :song_id, :integer
    remove_column :playlist_items, :name
  end

  def down
    remove_column :playlist_items, :song_id
    add_column :playlist_items, :name, :string
  end
end
