require 'rails_helper'

feature 'user signs up', %{
  As a customer
  I want to create an account
  So that I can use the site
} do

  # Acceptance Criteria:
  # - [ ] I must specify a valid email address
  # - [ ] I must specify a password and confirm that password
  # - [ ] If I do not give valid information, I get an error message
  # - [ ] If I specify valid information, register my account and authenticate

  scenario 'user specifies valid and required information' do
    visit root_path
    click_link 'Sign Up'

    fill_in 'First Name', with: 'firstname'
    fill_in 'Last Name', with: 'lastname'
    fill_in 'Company Name', with: 'My Company'
    fill_in 'Email', with: 'fake@email.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    choose 'Customer'
    click_button 'Sign Up'

    expect(page).to have_content('Welcome to the club!', count: 1)
    expect(page).to have_content('Sign Out')
  end

  scenario 'required information is not supplied' do
    visit root_path
    click_link 'Sign Up'

    click_button 'Sign Up'
    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'password does not match confirmation' do
    visit root_path
    click_link 'Sign Up'

    fill_in 'First Name', with: 'firstname'
    fill_in 'Last Name', with: 'lastname'
    fill_in 'Email', with: 'fake@email.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'anotherpassword'
    click_button 'Sign Up'

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content('Sign Out')
  end
end
