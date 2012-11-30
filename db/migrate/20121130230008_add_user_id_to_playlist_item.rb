class AddUserIdToPlaylistItem < ActiveRecord::Migration
  def change
    add_column :playlist_items, :user_id, :integer
  end
end
