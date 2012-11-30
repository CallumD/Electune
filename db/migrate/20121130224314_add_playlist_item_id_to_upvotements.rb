class AddPlaylistItemIdToUpvotements < ActiveRecord::Migration
  def change
    add_column :upvotements, :playlist_item_id, :integer
    remove_column :upvotements, :song_id, :integer
  end
end
