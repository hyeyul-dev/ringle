class GroupPolicy < ApplicationPolicy
  def update?
    record.user_ids.include?(user.id)
  end
end
