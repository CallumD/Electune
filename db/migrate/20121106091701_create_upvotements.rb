class CreateUpvotements < ActiveRecord::Migration[7.0]
  def change
    create_table :upvotements do |t|
      t.integer :song_id
      t.integer :upvoter_id

      t.timestamps
    end
  end
end
