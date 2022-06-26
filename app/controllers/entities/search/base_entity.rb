class Entities::Search::BaseEntity < Grape::Entity
  expose :music, using: Entities::Musics::DetailEntity
  expose :album, using: Entities::Albums::BaseEntity

  def music
    object
  end
end
