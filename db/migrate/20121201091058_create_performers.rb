class CreatePerformers < ActiveRecord::Migration[7.0]
  def change
    create_table :performers do |t|
      t.integer :song_id
      t.integer :artist_id

      t.timestamps
    end
    add_index(:performers, :song_id)
    add_index(:performers, :artist_id)
  end
end
