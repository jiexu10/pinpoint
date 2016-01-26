FactoryGirl.define do
  factory :user do
    first_name "Test"
    sequence(:last_name) { |n| "User#{n}" }
    sequence(:email) { |n| "user#{n}@test.com" }
    password "password"
    role "user"

    trait :driver do
      last_name "Driver"
      role "driver"
    end
  end
end
