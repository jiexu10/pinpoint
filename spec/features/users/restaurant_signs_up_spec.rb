require 'rails_helper'

feature 'restaurant signs up', %{
  As a restaurant
  I want to create an account
  So that I can have my restaurant on the site
} do

  # Acceptance Criteria:
  # - [x] I must specify a company name
  # - [x] I must specify a valid email address
  # - [x] I must specify a password and confirm that password
  # - [x] If I do not give valid information, I get an error message
  # - [x] If I specify valid information, register my account and authenticate

  scenario 'restaurant specifies valid and required information' do
    visit root_path
    click_link 'Sign Up'

    click_link 'Restaurant Sign Up'

    fill_in 'First Name', with: 'firstname'
    fill_in 'Last Name', with: 'lastname'
    fill_in 'Company Name', with: 'My Company'
    fill_in 'Email', with: 'fake@email.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content('Account Created!')
    expect(page).to have_content('Sign Out')
  end

  scenario 'required information of company name is not supplied' do
    visit root_path
    click_link 'Sign Up'

    click_link 'Restaurant Sign Up'

    fill_in 'First Name', with: 'firstname'
    fill_in 'Last Name', with: 'lastname'
    fill_in 'Email', with: 'fake@email.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content('Sign Out')
  end
end
