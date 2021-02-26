# frozen_string_literal: true

class Timer < ApplicationRecord
  validates :duration, presence: true
end
