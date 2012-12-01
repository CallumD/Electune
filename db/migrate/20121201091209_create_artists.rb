class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.string :spotify_link

      t.timestamps
    end
    add_index(:artists, :spotify_link, unique: true)
  end
end
