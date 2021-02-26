# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer

  set_id :id

  attributes :first_name, :last_name, :birthdate, :email

  attribute :gender do |user|
    user.gender.capitalize
  end

  attribute :height do |user|
    user.height.to_s
  end

  attribute :weight do |user|
    user.weight.to_s
  end

  has_many :training_sessions
end
