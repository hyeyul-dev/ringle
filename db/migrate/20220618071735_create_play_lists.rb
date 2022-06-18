class CreatePlayLists < ActiveRecord::Migration[6.1]
  def up
    create_table :play_lists do |t|
      t.references :target, polymorphic: true

      t.timestamps
    end
  end

  def down
    drop_table :play_lists
  end
end
