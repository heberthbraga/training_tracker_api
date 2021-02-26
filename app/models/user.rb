# frozen_string_literal: true

class User < ApplicationRecord
  extend Enumerize

  rolify
  has_secure_password

  has_many :identities, dependent: :destroy
  has_many :training_sessions, class_name: 'TrainingSession', foreign_key: 'owner_id',
                               dependent: :destroy

  has_one :height, class_name: 'Height', dependent: :destroy
  has_one :weight, class_name: 'Weight', dependent: :destroy

  enumerize :gender, in: %i[male female other]

  validates :email, presence: true, uniqueness: { case_sensitive: true }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, :last_name, :gender, presence: true

  scope :active, -> { where(active: true) }

  def admin?
    has_role?(:admin)
  end

  def newuser?
    has_role?(:newuser)
  end

  def registered?
    has_role?(:registered, :any)
  end

  def authorized?(record)
    (admin? || registered?) && self === record
  end
end
