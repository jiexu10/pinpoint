FactoryGirl.define do
  factory :user do
    first_name "Test"
    last_name "User"
    sequence(:email) { |n| "user#{n}@test.com" }
    password "password"
    role 'Customer'

    trait :restaurant do
      role 'Restaurant'
    end
  end
end
