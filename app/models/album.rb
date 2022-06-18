# == Schema Information
#
# Table name: albums
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Album < ApplicationRecord
  has_many :musics, dependent: :destroy
  has_many :artists, through: :musics
end
