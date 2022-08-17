class AddLinkToSongs < ActiveRecord::Migration[7.0]
  def change
    add_column :songs, :link, :string
  end
end
