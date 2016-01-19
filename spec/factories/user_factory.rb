FactoryGirl.define do
  factory :user do
    first_name "Test"
    last_name "User"
    sequence(:email) { |n| "user#{n}@test.com" }
    password "password"
  end
end
