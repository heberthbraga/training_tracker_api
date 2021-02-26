# frozen_string_literal: true

class UserTrainingSessionsSerializer
  include JSONAPI::Serializer

  set_id :id
  attributes :deadline
end
