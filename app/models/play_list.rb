# == Schema Information
#
# Table name: play_lists
#
#  id          :bigint           not null, primary key
#  target_type :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  target_id   :bigint
#
# Indexes
#
#  index_play_lists_on_target_id_and_target_type  (target_id,target_type) UNIQUE
#
class PlayList < ApplicationRecord
  belongs_to :target, polymorphic: true, foreign_key: 'target_id'

  has_many :musics, through: :music_play_lists, dependent: :destroy

  validates :target_type, inclusion: { in: %w[User Group] }
  validates :target_id, uniqueness: { scope: :target_type }
end
