class Entities::Groups::BaseEntity < Grape::Entity
  expose :id, documentation: { type: 'Integer', desc: '재생목록 id' }
  expose :name, documentation: { type: 'String', desc: '노래 제목' }
  expose :users, using: Entities::Users::BaseEntity
end
