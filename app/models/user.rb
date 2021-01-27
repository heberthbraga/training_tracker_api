class User < ApplicationRecord
  extend Enumerize

  rolify
  has_secure_password
  
  has_many :identities, dependent: :destroy
  has_many :training_sessions, class_name: 'TrainingSession', foreign_key: 'owner_id', dependent: :destroy

  has_one :height, class_name: 'Height', foreign_key: :user_id, dependent: :destroy
  has_one :weight, class_name: 'Weight', foreign_key: :user_id, dependent: :destroy

  enumerize :gender, in: [:male, :female, :other]

  validates :email, presence: true, uniqueness: { case_sensitive: true }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_presence_of :first_name, :last_name, :gender

  scope :active, -> { where(active: true) }

  def admin?
    self.has_role?(:admin)
  end

  def newuser?
    self.has_role?(:newuser)
  end

  def registered?
    self.has_role?(:registered, :any)
  end

  def authorized? record
    self.registered? && self === record
  end
end
