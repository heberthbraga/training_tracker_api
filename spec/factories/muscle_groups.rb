FactoryBot.define do
  factory :muscle_group, class: MuscleGroup do
    factory :biceps do
      name { 'biceps' }
    end
  end
end