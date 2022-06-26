class Entities::MusicUserPlaylists::BaseEntity < Grape::Entity
  expose :id, documentation: { type: 'Integer', desc: '재생목록 id' }
  expose :music, using: Entities::Musics::BaseEntity
end
