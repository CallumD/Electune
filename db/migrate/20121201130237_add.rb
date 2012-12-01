class Add < ActiveRecord::Migration
  def change
   change_column :playlist_items, :playlist_id, :integer, :limit => nil
  end
end
