# == Schema Information
#
# Table name: user_playlists
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_playlists_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserPlaylist < ApplicationRecord
  belongs_to :user

  has_many :music_user_playlists, dependent: :destroy, inverse_of: :user_playlist
  has_many :musics, through: :music_user_playlists
end
