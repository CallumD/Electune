class AddFirstPlayToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :first_play, :boolean
  end
end
