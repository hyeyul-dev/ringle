class CreateGroupPlaylists < ActiveRecord::Migration[6.1]
  def up
    create_table :group_playlists do |t|
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :group_playlists
  end
end
