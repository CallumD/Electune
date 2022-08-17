class ChangeTypeOfPlaylistId < ActiveRecord::Migration[7.0]
  def up
    remove_column :playlist_items, :playlist_id
    add_column :playlist_items, :playlist_id, :integer
  end

  def down
    remove_column :playlist_items, :playlist_id
    add_column :playlist_items, :playlist_id, :string
  end
end
