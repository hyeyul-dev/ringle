class Entities::Musics::BaseEntity < Grape::Entity
  expose :id, documentation: { type: 'Integer', desc: '재생목록 id' }
  expose :title, documentation: { type: 'String', desc: '노래 제목' }
end
