class Entities::UserGroups::BaseEntity < Grape::Entity
  expose :id, documentation: { type: 'Integer', desc: 'user_group id' }
  expose :user_id, documentation: { type: 'Integer', desc: '유저 id' }
end
