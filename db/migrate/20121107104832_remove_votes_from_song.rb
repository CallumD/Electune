class RemoveVotesFromSong < ActiveRecord::Migration
  def up
    remove_column :songs, :votes
  end

  def down
    add_column :songs, :votes, :integer
  end
end
