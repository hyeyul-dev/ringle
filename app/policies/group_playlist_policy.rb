class GroupPlaylistPolicy < ApplicationPolicy
  def create?
    if record.group.user_ids.include?(user.id)
      true
    else
      record.errors.add(:group_playlist, 'User does not belong to the group')
    end
  end

  alias update? create?
  alias delete? create?
end
