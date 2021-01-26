class UserPolicy < ApplicationPolicy
  def details?
    user.authorized? record
  end

  def create?
    user.authorized? record
  end
end