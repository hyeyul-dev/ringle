class CreateArtists < ActiveRecord::Migration[6.1]
  def up
    create_table :artists do |t|
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :artists
  end
end
