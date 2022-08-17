class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.datetime :release_date
      t.string :link

      t.timestamps
    end

    add_index(:albums, :link, unique: true)
  end
end
