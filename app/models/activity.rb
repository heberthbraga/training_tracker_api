# frozen_string_literal: true

class Activity < ApplicationRecord
  extend Enumerize

  belongs_to :timer
  belongs_to :training_session

  accepts_nested_attributes_for :timer

  enumerize :activity_type, in: [:workout]

  has_many :workouts, -> { order(position: :asc) }, dependent: :destroy

  validates :training_session, presence: true
  validates :activity_type, presence: true
  validates :name, presence: true
  validates :phases, presence: true
end
