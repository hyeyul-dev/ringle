# == Schema Information
#
# Table name: musics
#
#  id         :bigint           not null, primary key
#  like_count :integer          default(0)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  album_id   :bigint           not null
#
# Indexes
#
#  index_musics_on_album_id  (album_id)
#
# Foreign Keys
#
#  fk_rails_...  (album_id => albums.id)
#
class Music < ApplicationRecord
  belongs_to :album

  has_many :artists, through: :music_artists
end
