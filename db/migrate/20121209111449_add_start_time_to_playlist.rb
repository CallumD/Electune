class AddStartTimeToPlaylist < ActiveRecord::Migration[7.0]
  def change
    add_column :playlists, :start_time, :datetime
  end
end
