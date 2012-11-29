class AddLinkToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :link, :string
  end
end
