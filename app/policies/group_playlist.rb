class GroupPlaylistPolicy < ApplicationPolicy
  def create?
    record.group.user_ids.include?(user.id)
  end



  alias update? create?
  alias delete? create?
end
