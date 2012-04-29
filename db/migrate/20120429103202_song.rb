class Song < ActiveRecord::Migration
  def up
    create_table :songs do |t|
      t.integer :votes
      t.string :playlist_name
    end
  end

  def down
    drop_table :songs
  end
end
