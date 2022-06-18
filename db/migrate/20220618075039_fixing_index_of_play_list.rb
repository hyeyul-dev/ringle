class FixingIndexOfPlayList < ActiveRecord::Migration[6.1]
  def up
    remove_index :play_lists, name: 'index_play_lists_on_target'
    add_index :play_lists, %i[target_id target_type], unique: true
  end

  def down
    remove_index :play_lists, %i[target_id target_type], unique: true
    add_index :play_lists, %i[target_type target_id]
  end
end
