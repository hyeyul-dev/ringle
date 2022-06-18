# == Schema Information
#
# Table name: music_artists
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  artist_id  :bigint           not null
#  music_id   :bigint           not null
#
# Indexes
#
#  index_music_artists_on_artist_id  (artist_id)
#  index_music_artists_on_music_id   (music_id)
#
# Foreign Keys
#
#  fk_rails_...  (artist_id => artists.id)
#  fk_rails_...  (music_id => musics.id)
#
class MusicArtist < ApplicationRecord
  belongs_to :music
  belongs_to :artist
end
