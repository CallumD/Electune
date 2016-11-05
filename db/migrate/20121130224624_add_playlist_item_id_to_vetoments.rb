class AddPlaylistItemIdToVetoments < ActiveRecord::Migration
  def up
    add_column :vetoments, :playlist_item_id, :integer
    remove_column :vetoments, :song_id
  end

  def down
    remove_column :vetoments, :playlist_item_id
    add_column :vetoments, :song_id, :integer
  end
end
