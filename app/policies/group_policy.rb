class GroupPolicy < ApplicationPolicy
  def update?
    if record.user_ids.include?(user.id)
      true
    else
      record.errors.add(:group, 'User does not belong to the group ')
    end
    record.errors.empty?
  end
end
