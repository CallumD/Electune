class IncreaseSongNameSize < ActiveRecord::Migration[7.0]
  def up
    remove_column :songs, :name
    add_column :songs, :name, :string, limit: 1000
  end

  def down
    remove_column :songs, :name
    add_column :songs, :name, :string
  end
end
