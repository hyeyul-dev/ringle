class Entities::Artists::BaseEntity < Grape::Entity
  expose :id, documentation: { type: 'Integer', desc: '아티스트 id' }
  expose :name, documentation: { type: 'String', desc: '아티스트 이름' }
end
