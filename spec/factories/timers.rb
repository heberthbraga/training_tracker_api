FactoryBot.define do
  factory :timer, class: Timer do
    factory :one_hour do
      duration  { 3600 }
    end
  end
end