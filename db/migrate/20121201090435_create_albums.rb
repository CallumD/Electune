class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.datetime :release_date
      t.string :spotify_link

      t.timestamps
    end

   add_index(:albums, :spotify_link, unique: true)
  end
end
