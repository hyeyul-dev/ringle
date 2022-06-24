class CreateUserPlayLists < ActiveRecord::Migration[6.1]
  def change
    return if table_exists?(:user_play_lists)

    create_table :user_play_lists do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
