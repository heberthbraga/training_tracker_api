class TrainingSession < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :activities, dependent: :destroy

  validates_presence_of :name
  validates_presence_of :deadline
  validates_presence_of :owner

  def fetch_activities options = { completed: false }
    self.activities.where(activities: { completed: options[:completed] })
  end
end
