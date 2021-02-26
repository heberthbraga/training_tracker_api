# frozen_string_literal: true

class TrainingSession < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :activities, dependent: :destroy

  validates :name, presence: true
  validates :deadline, presence: true
  validates :owner, presence: true

  def fetch_activities(options = { completed: false })
    activities.where(activities: { completed: options[:completed] })
  end
end
