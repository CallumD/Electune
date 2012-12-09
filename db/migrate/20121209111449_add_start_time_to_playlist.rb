class AddStartTimeToPlaylist < ActiveRecord::Migration
  def change
    add_column :playlists, :start_time, :datetime
  end
end
