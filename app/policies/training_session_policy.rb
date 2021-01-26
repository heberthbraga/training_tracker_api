class TrainingSessionPolicy < ApplicationPolicy
  def show?
    owner?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  def activities?
    owner?
  end

private

  def training_session
    record
  end

  def owner?
    user.registered? && user === training_session.owner
  end
end