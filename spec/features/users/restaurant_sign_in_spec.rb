require 'rails_helper'

feature 'restaurant signs in', %{
  As a restaurant
  I want to sign in
  So that I can see my orders
}, vcr: true do

  # Acceptance Criteria:
  # - [x] If I specify a valid, previous registered email and password,
  #   I am authenticated and I am directed to my restaurant show page
  # - [x] If I specify an invalid email and password, I remain unauthenticated
  # - [x] If I am already signed in, I can't sign in again

  let(:rest) { create_restaurant('Boston Beer Garden') }

  scenario 'an existing restaurant specifies a valid email and password' do
    visit root_path
    click_link 'Restaurant Sign In'
    fill_in 'Email', with: rest.email
    fill_in 'Password', with: rest.password
    click_button 'Log In'

    expect(current_path).to eq(restaurant_path(rest))
    expect(page).to have_content('Welcome back!')
    expect(page).to have_content('Sign Out')
    expect(page).to have_content(rest.company_name)
  end
end
