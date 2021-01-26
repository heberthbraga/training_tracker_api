class WorkoutExercise < ApplicationRecord
  belongs_to :workout
  belongs_to :muscle_group
  belongs_to :exercise

  accepts_nested_attributes_for :exercise, :muscle_group

  validates_presence_of :workout
  validates_presence_of :muscle_group
  validates_presence_of :exercise
  validates_presence_of :weights
  validates_presence_of :series
  validates_presence_of :repetitions
end
