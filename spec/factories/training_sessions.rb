FactoryBot.define do
  factory :training_session, class: TrainingSession do
    name            { Faker::Esport.event }
    deadline        { Faker::Time.forward(days: 23, period: :morning) }
  end
end