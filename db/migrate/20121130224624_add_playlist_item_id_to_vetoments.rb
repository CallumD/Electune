class AddPlaylistItemIdToVetoments < ActiveRecord::Migration
  def change
    add_column :vetoments, :playlist_item_id, :integer
    remove_column :vetoments, :song_id, :integer
  end
end
