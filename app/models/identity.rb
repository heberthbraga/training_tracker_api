class Identity < ApplicationRecord
  belongs_to :user

  validates_presence_of :provider
end
