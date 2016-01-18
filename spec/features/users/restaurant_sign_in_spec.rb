require 'rails_helper'

feature 'restaurant signs in', %{
  As a restaurant
  I want to sign in
  So that I can see my orders
} do

  # Acceptance Criteria:
  # - [ ] If I specify a valid, previous registered email and password,
  #   I am authenticated and I am directed to my restaurant show page
  # - [ ] If I specify an invalid email and password, I remain unauthenticated
  # - [ ] If I am already signed in, I can't sign in again

  let (:user) { FactoryGirl.create(:user, :restaurant) }

  scenario 'an existing user specifies a valid email and password' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content('Welcome back!')
    expect(page).to have_content('Sign Out')
    expect(page).to have_content("First Name: #{user.first_name}")
    expect(page).to have_content("Last Name: #{user.last_name}")
    expect(page).to have_content("Company Name: #{user.company_name}")
  end
end
