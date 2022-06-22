class FixColumnName < ActiveRecord::Migration[6.1]
  def up
    rename_column :albums, :name, :title
    rename_column :musics, :name, :title
  end

  def down
    rename_column :albums, :title, :name
    rename_column :musics, :title, :name
  end
end
