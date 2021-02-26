# frozen_string_literal: true

class WorkoutExerciseSerializer
  include JSONAPI::Serializer

  set_id :id

  attribute :activity_name do |object|
    object.workout.activity.name
  end

  attribute :exercise_name do |object|
    object.exercise.name
  end

  attribute :muscle_name do |object|
    object.muscle_group.name
  end

  attributes :weights, :series, :repetitions
end
