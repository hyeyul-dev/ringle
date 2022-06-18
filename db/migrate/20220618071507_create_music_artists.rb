class CreateMusicArtists < ActiveRecord::Migration[6.1]
  def up
    create_table :music_artists do |t|
      t.references :music, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :music_artists
  end
end
