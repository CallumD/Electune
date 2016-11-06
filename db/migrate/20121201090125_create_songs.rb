class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :length
      t.string :link
      t.integer :album_id

      t.timestamps
    end
    add_index(:songs, :link, unique: true)
  end
end
