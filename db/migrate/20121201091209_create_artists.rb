class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.string :link

      t.timestamps
    end
    add_index(:artists, :link, unique: true)
  end
end
