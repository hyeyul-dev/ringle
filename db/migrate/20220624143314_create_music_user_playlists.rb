class CreateMusicUserPlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :music_user_playlists do |t|
      t.references :user_playlist, null: false, foreign_key: true
      t.references :music, null: false, foreign_key: true

      t.timestamps
    end
  end
end
