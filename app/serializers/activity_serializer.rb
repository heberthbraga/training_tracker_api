# frozen_string_literal: true

class ActivitySerializer
  include JSONAPI::Serializer

  set_id :id

  attributes :name, :activity_type, :phases, :completed

  attribute :duration do |object|
    object.timer.duration
  end

  # belongs_to :owner, record_type: :user, serializer: UserSerializer
end
