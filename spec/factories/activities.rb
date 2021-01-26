FactoryBot.define do
  factory :wi, class: Activity do
    factory :activity_a do
      name            { 'Training A' }
      activity_type   { 'workout' }
      timer           { association(:one_hour) }
      phases          { 20 }
      completed       { false }
    end
  end
end