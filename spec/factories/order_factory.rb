FactoryGirl.define do
  factory :order do
    cart
    restaurant
    user
  end
end
