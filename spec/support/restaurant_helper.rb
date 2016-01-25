def create_restaurant(name)
  restaurant = FactoryGirl.create(:restaurant, company_name: name)
  MakeRestaurantDetail.new(restaurant, 'name' => restaurant.company_name)
  restaurant
end

def restaurant_sign_in(restaurant)
  visit new_restaurant_session_path
  fill_in 'Email', with: restaurant.email
  fill_in 'Password', with: restaurant.password
  click_button 'Log In'
end
