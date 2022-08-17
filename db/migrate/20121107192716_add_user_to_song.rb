class AddUserToSong < ActiveRecord::Migration[7.0]
  def change
    add_column :songs, :user_id, :integer
  end
end
