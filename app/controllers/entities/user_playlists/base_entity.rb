class Entities::UserPlaylists::BaseEntity < Grape::Entity
  expose :id, documentation: { type: 'Integer', desc: '재생목록 id' }
  expose :musics, using: Entities::Musics::BaseEntity
end
