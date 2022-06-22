class CreateMusicPlayLists < ActiveRecord::Migration[6.1]
  def change
    create_table :music_play_lists do |t|
      t.references :play_list, null: false, foreign_key: true
      t.references :music, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :music_play_lists
  end
end
