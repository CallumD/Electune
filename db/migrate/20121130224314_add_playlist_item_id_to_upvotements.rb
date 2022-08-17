class AddPlaylistItemIdToUpvotements < ActiveRecord::Migration[7.0]
  def up
    add_column :upvotements, :playlist_item_id, :integer
    remove_column :upvotements, :song_id
  end

  def down
    remove_column :upvotements, :playlist_item_id
    add_column :upvotements, :song_id, :integer
  end
end
