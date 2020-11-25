class MovePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    return true
  end

  def update?
    user_is_owner? || user_is_admin?
  end

  def destroy?
    user_is_owner? || user_is_admin?
  end

  def user_is_admin?
    user.admin
  end

  def user_is_owner?
    user == record.user
  end
end
