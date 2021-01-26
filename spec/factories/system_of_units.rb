FactoryBot.define do
  factory :system_of_unit, class: SystemOfUnit do
    factory :kilogram do
      description            { 'Kilogram' }
      symbol                 { 'kg' }
    end
    factory :centimeter do
      description            { 'Centimeter' }
      symbol                 { 'cm' }
    end
  end
end