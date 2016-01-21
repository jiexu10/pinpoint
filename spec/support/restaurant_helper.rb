def create_restaurant(name)
  restaurant = FactoryGirl.create(:restaurant, company_name: name)
  MakeRestaurantDetail.new(restaurant, 'name' => restaurant.company_name)
  restaurant
end
