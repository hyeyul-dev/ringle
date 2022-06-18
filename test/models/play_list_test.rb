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
require "test_helper"

class PlayListTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
