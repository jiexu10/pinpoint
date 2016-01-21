FactoryGirl.define do
  factory :restaurant do
    first_name "TestRest"
    last_name "UserRest"
    company_name 'fake restaurant name'
    sequence(:email) { |n| "rest#{n}@test.com" }
    password "password"

    trait :beergard do
      company_name 'Boston Beer Garden'
    end
  end
end
