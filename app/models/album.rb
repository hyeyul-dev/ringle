# == Schema Information
#
# Table name: albums
#
#  id         :bigint           not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ApplicationRecord
  has_many :musics, dependent: :destroy
  has_many :artists, through: :musics

  after_commit :update_to_elasticsearch, on: :update

  def update_to_elasticsearch
    Search::Music.update_album(self)
  end
end
