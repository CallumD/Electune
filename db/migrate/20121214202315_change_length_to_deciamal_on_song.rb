class ChangeLengthToDeciamalOnSong < ActiveRecord::Migration[7.0]
  def up
    remove_column :songs, :length
    add_column :songs, :length, :decimal, precision: 8, scale: 3
  end

  def down
    remove_column :songs, :length, :decimal, precision: 8, scale: 3
    add_column :songs, :length
  end
end
