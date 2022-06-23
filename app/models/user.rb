# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  has_one :play_list, as: :target, dependent: :destroy
  has_many :groups, through: :user_groups, dependent: :destroy
end
