# frozen_string_literal: true

class WorkoutExercise < ApplicationRecord
  belongs_to :workout
  belongs_to :muscle_group
  belongs_to :exercise

  accepts_nested_attributes_for :exercise, :muscle_group

  validates :workout, presence: true
  validates :muscle_group, presence: true
  validates :exercise, presence: true
  validates :weights, presence: true
  validates :series, presence: true
  validates :repetitions, presence: true
end
