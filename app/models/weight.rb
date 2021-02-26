# frozen_string_literal: true

class Weight < ApplicationRecord
  belongs_to :user
  belongs_to :system_of_unit

  validates :value, :user, :system_of_unit, presence: true

  def to_s
    "#{value} #{system_of_unit.symbol}"
  end
end
