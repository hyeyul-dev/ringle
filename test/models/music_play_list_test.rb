# == Schema Information
#
# Table name: music_play_lists
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  music_id     :bigint           not null
#  play_list_id :bigint           not null
#
# Indexes
#
#  index_music_play_lists_on_music_id      (music_id)
#  index_music_play_lists_on_play_list_id  (play_list_id)
#
# Foreign Keys
#
#  fk_rails_...  (music_id => musics.id)
#  fk_rails_...  (play_list_id => play_lists.id)
#
require "test_helper"

class MusicPlayListTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
