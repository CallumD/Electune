class AddSongIdToPlaylistItem < ActiveRecord::Migration
  def change
    add_column :playlist_items, :song_id, :integer
    remove_column :playlist_items, :name, :string
    remove_column :playlist_items, :link, :string
  end
end
