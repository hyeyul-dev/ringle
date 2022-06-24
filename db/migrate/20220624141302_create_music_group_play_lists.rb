class CreateMusicGroupPlayLists < ActiveRecord::Migration[6.1]
  def up
    create_table :music_group_play_lists do |t|
      t.references :group_playlist, null: false, foreign_key: true
      t.references :music, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :music_group_play_lists
  end
end
