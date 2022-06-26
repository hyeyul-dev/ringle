class UserPlaylistPolicy < ApplicationPolicy
  def show?
    record.user_id == user.id
  end

  alias update? show?
  alias delete? show?
end
