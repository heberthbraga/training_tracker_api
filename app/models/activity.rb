class Activity < ApplicationRecord
  extend Enumerize

  belongs_to :timer
  belongs_to :training_session

  accepts_nested_attributes_for :timer

  enumerize :activity_type, in: [:workout]
  
  has_many :workouts, -> { order(position: :asc) }, dependent: :destroy

  validates_presence_of :training_session
  validates_presence_of :activity_type
  validates_presence_of :name
  validates_presence_of :phases
end
