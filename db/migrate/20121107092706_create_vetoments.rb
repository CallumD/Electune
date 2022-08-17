class CreateVetoments < ActiveRecord::Migration[7.0]
  def change
    create_table :vetoments do |t|
      t.integer :song_id
      t.integer :vetoer_id

      t.timestamps
    end
  end
end
