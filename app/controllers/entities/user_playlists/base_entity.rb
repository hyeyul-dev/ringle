class Entities::UserPlaylists::BaseEntity < Grape::Entity
  expose :id, documentation: { type: 'Integer', desc: '재생목록 id' }
  expose :music_user_playlists, using: Entities::MusicUserPlaylists::BaseEntity

  def music_user_playlists
    object.music_user_playlists.preload(music: :artists)
  end
end
