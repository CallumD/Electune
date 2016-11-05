class IncreaseSongNameSize < ActiveRecord::Migration
  def up
    remove_column :songs, :name
    add_column :songs, :name, :string, limit: 1000
  end

  def down
    remove_column :songs, :name
    add_column :songs, :name, :string
  end
end
