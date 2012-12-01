class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :length
      t.string :spotify_link
      t.integer :album_id

      t.timestamps
    end
    add_index(:songs, :spotify_link, unique: true)
  end
end
