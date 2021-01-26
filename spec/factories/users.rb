FactoryBot.define do
  factory :user, class: User do
    first_name       { Faker::Name.first_name }
    last_name        { Faker::Name.last_name }
    email            { Faker::Internet.email }
    password         { Faker::Internet.password(min_length: 8) }
    gender           { 'male' }

    after(:create) do |user|
      create(:height, value: 181, user: user, system_of_unit: create(:centimeter))
      create(:height, value: 73, user: user, system_of_unit: create(:kilogram))
    end

    factory :admin do
      after(:create) {|user| user.add_role(:admin)}
    end

    factory :newuser do
    end

    factory :registered do
      after(:create) {|user| user.add_role(:registered)}
    end
  end
end