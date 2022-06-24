class FixTakbleName < ActiveRecord::Migration[6.1]
  def change
    rename_table :user_play_lists, :user_playlists unless table_exists?(:user_playlists)
    rename_table :group_play_lists, :group_playlists unless table_exists?(:group_playlists)
    rename_table :music_user_play_lists, :music_user_playlists unless table_exists?(:music_user_playlists)
    rename_table :music_group_play_lists, :music_group_playlists unless table_exists?(:music_group_playlists)

    rename_column :music_user_playlists, :user_play_list_id, :user_playlist_id
    rename_column :music_group_playlists, :group_play_list_id, :group_playlist_id
  end
end
