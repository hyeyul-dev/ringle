# == Schema Information
#
# Table name: group_play_lists
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :bigint           not null
#
# Indexes
#
#  index_group_play_lists_on_group_id  (group_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#
require "test_helper"

class GroupPlayListTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
