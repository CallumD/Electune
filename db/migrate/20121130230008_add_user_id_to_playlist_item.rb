class AddUserIdToPlaylistItem < ActiveRecord::Migration[7.0]
  def change
    add_column :playlist_items, :user_id, :integer
  end
end
