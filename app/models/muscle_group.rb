# frozen_string_literal: true

class MuscleGroup < ApplicationRecord
  validates :name, presence: true
end
