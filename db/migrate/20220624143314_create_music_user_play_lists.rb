class CreateMusicUserPlayLists < ActiveRecord::Migration[6.1]
  def change
    return if table_exists?(:music_user_play_lists)

    create_table :music_user_play_lists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :music, null: false, foreign_key: true

      t.timestamps
    end
  end
end
