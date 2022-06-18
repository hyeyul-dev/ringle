class CreateAlbums < ActiveRecord::Migration[6.1]
  def up
    create_table :albums do |t|
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :albums
  end
end
