class UserPlaylistPolicy < ApplicationPolicy
  def show?
    if record.user_id == user.id
    else
      record.errors.add(:user, 'User is not invalid')
    end
  end

  alias update? show?
  alias delete? show?
end
