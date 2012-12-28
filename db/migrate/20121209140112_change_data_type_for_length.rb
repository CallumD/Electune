class ChangeDataTypeForLength < ActiveRecord::Migration
  def up
    remove_column :songs, :length
    add_column :songs, :length, :integer
  end

  def down
    remove_column :songs, :length
    add_column :songs, :length, :string
  end
end
