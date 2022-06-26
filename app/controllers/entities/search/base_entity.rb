class Entities::Search::BaseEntity < Grape::Entity
  expose :music_title, documentation: { type: 'String', desc: '노래 제목' }
  expose :album_title, documentation: { type: 'String', desc: '앨범 제목' }
  expose :artists_name, documentation: { type: 'String', desc: '가수 이름', is_array: true }
  expose :like_count, documentation: { type: 'Integer', desc: '좋아요 수' }
  expose :created_at, documentation: { type: 'Datetime', desc: '생성 시각' }

  def music_title
    object.title
  end

  def album_title
    object.album.title
  end

  def artists_name
    object.artists.pluck(:name)
  end
end
