require 'rails_helper'

feature 'user signs out', %{
  As a user
  I want to sign out
  So that I can securely leave the site
} do

  # Acceptance Criteria:
  # - [x] If I am logged in, I can log out
  # - [x] If I am not logged in, there is no option to log out
  # - [x] If I sign out, I can sign back in
  # - [x] Restaurant account can sign out

  let (:user) { FactoryGirl.create(:user) }
  let (:restaurant) { FactoryGirl.create(:restaurant) }

  scenario 'a signed-in user logs out' do
    user_sign_in(user)
    click_link 'Sign Out'

    expect(page).to have_content('Signed out successfully.')
    expect(page).to have_content('Sign In')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'a signed-in restaurant logs out' do
    restaurant_sign_in(restaurant)
    click_link 'Sign Out'

    expect(page).to have_content('Signed out successfully.')
    expect(page).to have_content('Sign In')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'a logged out user cannot log out' do
    visit root_path

    expect(page).to_not have_content('Sign Out')
  end

  scenario 'a user can sign out and then back in' do
    user_sign_in(user)
    click_link 'Sign Out'

    expect(page).to have_content('Signed out successfully.')
    expect(page).to have_content('Sign In')
    expect(page).to_not have_content('Sign Out')

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    expect(page).to have_content('Welcome back!')
  end
end
