FactoryGirl.define do
  factory :restaurant do
    first_name "TestRest"
    last_name "UserRest"
    company_name 'restaurant name'
    sequence(:email) { |n| "rest#{n}@test.com" }
    password "password"
  end
end
