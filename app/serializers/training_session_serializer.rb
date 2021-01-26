class TrainingSessionSerializer
  include JSONAPI::Serializer
  
  set_id :id

  attributes :name, :deadline

  # belongs_to :owner, record_type: :user, serializer: UserSerializer
end