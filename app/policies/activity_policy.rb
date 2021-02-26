# frozen_string_literal: true

class ActivityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end

  def show?
    owner?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  def finish?
    owner?
  end

  private

  def activity
    record
  end

  def owner?
    user.registered? && user === activity.training_session.owner
  end
end
