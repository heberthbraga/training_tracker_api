class Height < ApplicationRecord
  belongs_to :user
  belongs_to :system_of_unit

  validates_presence_of :value, :user, :system_of_unit

  def to_s
    "#{value} #{system_of_unit.symbol}"
  end
end
