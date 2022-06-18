class CreateMusics < ActiveRecord::Migration[6.1]
  def up
    create_table :musics do |t|
      t.string :name
      t.integer :like_count, default: 0
      t.references :album, foreign_key: true, null: false

      t.timestamps
    end
  end

  def down
    drop_table :musics
  end
end
