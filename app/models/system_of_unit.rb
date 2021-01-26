class SystemOfUnit < ApplicationRecord
  validates_presence_of :description
  validates_presence_of :symbol
end
