# frozen_string_literal: true

class Exercise < ApplicationRecord
  has_many :workout_exercises

  validates :name, presence: true
end
