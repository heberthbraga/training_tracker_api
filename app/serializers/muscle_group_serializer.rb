# frozen_string_literal: true

class MuscleGroupSerializer
  include JSONAPI::Serializer

  set_id :id

  attribute :name
end
