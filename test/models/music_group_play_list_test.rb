# == Schema Information
#
# Table name: music_group_play_lists
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  group_play_list_id :bigint           not null
#  music_id           :bigint           not null
#
# Indexes
#
#  index_music_group_play_lists_on_group_play_list_id  (group_play_list_id)
#  index_music_group_play_lists_on_music_id            (music_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_play_list_id => group_play_lists.id)
#  fk_rails_...  (music_id => musics.id)
#
require "test_helper"

class MusicGroupPlayListTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
