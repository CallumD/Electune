class AddFirstPlayToPlaylists < ActiveRecord::Migration[7.0]
  def change
    add_column :playlists, :first_play, :boolean
  end
end
