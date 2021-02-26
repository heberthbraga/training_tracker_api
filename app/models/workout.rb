# frozen_string_literal: true

class Workout < ApplicationRecord
  belongs_to :activity
  acts_as_list scope: :activity

  validates :activity, presence: true
end
