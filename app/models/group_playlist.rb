# == Schema Information
#
# Table name: group_playlists
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :bigint           not null
#
# Indexes
#
#  index_group_playlists_on_group_id  (group_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#
class GroupPlaylist < ApplicationRecord
  belongs_to :group

  has_many :music_group_playlists, dependent: :destroy, inverse_of: :group_playlist
  has_many :musics, through: :music_group_playlists
end
