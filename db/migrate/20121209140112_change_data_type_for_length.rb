class ChangeDataTypeForLength < ActiveRecord::Migration
  def up
    change_column :songs, :length, :integer
  end

  def down
    change_column :songs, :length, :string
  end
end
