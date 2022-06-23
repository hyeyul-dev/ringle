# == Schema Information
#
# Table name: artists
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artist < ApplicationRecord
  has_many :music_artists
  has_many :musics, through: :music_artists
  after_commit :update_musics, on: :update

  private

  def update_musics
    Music.update_music(musics)
  end
end
