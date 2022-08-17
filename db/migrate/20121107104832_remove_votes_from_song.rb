class RemoveVotesFromSong < ActiveRecord::Migration[7.0]
  def up
    remove_column :songs, :votes
  end

  def down
    add_column :songs, :votes, :integer
  end
end
