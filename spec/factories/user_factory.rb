FactoryGirl.define do
  factory :user do
    first_name "Test"
    last_name "User"
    sequence(:email) { |n| "user#{n}@test.com" }
    password "password"
    role '1'

    trait :restaurant do
      company_name 'restaurant name'
      role '2'
    end
  end
end
