# frozen_string_literal: true

class SystemOfUnit < ApplicationRecord
  validates :description, presence: true
  validates :symbol, presence: true
end
