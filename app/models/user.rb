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
  has_one :user_playlist, dependent: :destroy
  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups
  has_many :group_playlists, through: :group

  after_commit :create_playlist, on: :create

  alias playlist user_playlist

  def create_playlist
    UserPlaylist.create!(user_id: id)
  end
end
