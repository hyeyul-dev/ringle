class Entities::Albums::BaseEntity < Grape::Entity
  expose :id, documentation: { type: 'Integer', desc: '앫범 id' }
  expose :title, documentation: { type: 'String', desc: '앨범 제목' }
end
