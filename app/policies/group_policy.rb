class GroupPolicy < ApplicationPolicy
  def update?
   record.users.include?(user)
  end
end
