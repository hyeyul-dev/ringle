# == Schema Information
#
# Table name: music_group_playlists
#
#  id                :bigint           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  creator_id        :integer          not null
#  group_playlist_id :bigint           not null
#  music_id          :bigint           not null
#
# Indexes
#
#  index_music_group_playlists_on_group_playlist_id  (group_playlist_id)
#  index_music_group_playlists_on_music_id           (music_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_playlist_id => group_playlists.id)
#  fk_rails_...  (music_id => musics.id)
#
class MusicGroupPlaylist < ApplicationRecord
  belongs_to :music
  belongs_to :group_playlist
  belongs_to :creator, class_name: :User

  before_commit :delete_music_group_play_list, on: :create

  def delete_music_group_play_list
    group_playlist.music_group_playlists.first.destroy if group_playlist.music_group_playlists.size >= 10
  end
end
