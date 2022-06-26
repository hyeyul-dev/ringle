class Entities::UserPlaylists::BaseEntity < Grape::Entity
  expose :id, documentation: { type: 'Integer', desc: '재생목록 id' }
  expose :music_user_playlists, using: Entities::MusicUserPlaylists::BaseEntity
end
