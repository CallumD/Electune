class AddNameToPlaylistItems < ActiveRecord::Migration
  def change
    add_column :playlist_items, :name, :string
  end
end
