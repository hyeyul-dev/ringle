class Entities::Musics::DetailEntity < Entities::Musics::BaseEntity
  expose :like_count, documentation: { type: 'Integer', desc: '노래 좋아요 수' }
  expose :created_at, documentation: { type: 'Datetime', desc: '생성 시각'}
end
