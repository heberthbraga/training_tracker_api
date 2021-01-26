FactoryBot.define do
  factory :workout_exercise, class: WorkoutExercise do
    exercise      { association(:alternating_incline_dumbbell_curl) }
    weights       { '5' }
    series        { 3 }
    repetitions   { 10 }
    image         { 'url' }
    muscle_group  {  association(:biceps) }
  end 
end