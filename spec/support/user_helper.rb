def user_sign_in(user)
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Log In'
end

def restaurant_sign_in(restaurant)
  visit new_restaurant_session_path
  fill_in 'Email', with: restaurant.email
  fill_in 'Password', with: restaurant.password
  click_button 'Log In'
end
