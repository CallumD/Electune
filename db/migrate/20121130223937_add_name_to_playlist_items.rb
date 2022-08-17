class AddNameToPlaylistItems < ActiveRecord::Migration[7.0]
  def change
    add_column :playlist_items, :name, :string
  end
end
