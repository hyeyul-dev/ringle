class AddcolumnOnCreator < ActiveRecord::Migration[6.1]
  def up
    add_column :music_group_playlists, :creator_id, :integer, null: false, foreign_key: true
  end

  def down
    remove_column :music_group_playlists, :creator_id
  end
end
