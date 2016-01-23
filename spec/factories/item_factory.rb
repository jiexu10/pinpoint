FactoryGirl.define do
  factory :item do
    sequence(:name) { |n| "item#{n}" }
    price '8.99'
  end
end
