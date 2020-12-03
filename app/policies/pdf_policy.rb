class PDFPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def mail?
    user_is_owner? || user_is_admin?
  end

  def user_is_admin?
    user.admin
  end

  def user_is_owner?
    user == record.parent.move.user
  end
end
