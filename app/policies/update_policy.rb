class UpdatePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
      # TODO: figure out why 'has_one :user, through: :move' doesn't work here
      # scope.where(user: user)
    end
  end

  def show?
    user_is_owner? || user_is_admin?
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
