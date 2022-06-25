# == Schema Information
#
# Table name: groups
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Group < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  has_one :group_playlist, dependent: :destroy

  before_commit :create_playlist, on: :create

  alias playlist group_playlist

  accepts_nested_attributes_for :user_groups, allow_destroy: true

  def create_playlist
    GroupPlaylist.create!(group_id: id)
  end
end
