class Workout < ApplicationRecord
  belongs_to :activity
  acts_as_list scope: :activity

  validates_presence_of :activity
end
