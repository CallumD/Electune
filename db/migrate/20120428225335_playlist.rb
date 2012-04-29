class Playlist < ActiveRecord::Migration
  def up
    create_table :playlists do |t|
      t.string :name
    end
  end

  def down
    drop_table :playlists
  end
end
