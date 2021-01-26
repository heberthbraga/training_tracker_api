class WorkoutExercisePolicy < ApplicationPolicy

  def show?
    owner?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

private

  def workout_exercise
    record
  end

  def activity
    workout_exercise.workout.activity
  end

  def training_session
    activity.training_session
  end

  def owner?
    user.registered? && user === training_session.owner
  end
end