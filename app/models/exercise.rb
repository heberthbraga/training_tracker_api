class Exercise < ApplicationRecord

  has_many :workout_exercises

  validates_presence_of :name
end
