# == Schema Information
#
# Table name: music_user_playlists
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  music_id         :bigint           not null
#  user_playlist_id :bigint           not null
#
# Indexes
#
#  index_music_user_playlists_on_music_id          (music_id)
#  index_music_user_playlists_on_user_playlist_id  (user_playlist_id)
#
# Foreign Keys
#
#  fk_rails_...  (music_id => musics.id)
#  fk_rails_...  (user_playlist_id => user_playlists.id)
#
class MusicUserPlaylist < ApplicationRecord
  belongs_to :music
  belongs_to :user_playlist, foreign_key: 'user_playlist_id'

  before_commit :delete_music_user_playlist, on: :create

  def delete_music_user_playlist
    user_playlist.music_user_playlists.first.destroy if user_playlist.music_user_playlists.size >= 100
  end
end
