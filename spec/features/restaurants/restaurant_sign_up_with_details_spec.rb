require 'rails_helper'

feature 'restaurant signs up', %{
  As a restaurant
  I want to create an account
  So that I can have my restaurant on the site with all details
}, vcr: true, focus: true do

  # Acceptance Criteria:
  # - [x] I must specify a company name
  # - [x] I must see all of my company data on the site
  # - [x] I must specify a valid email address
  # - [x] I must specify a password and confirm that password
  # - [x] If I do not give valid information, I get an error message
  # - [x] If I specify valid information, register my account and authenticate

  let(:rest) { FactoryGirl.create(:restaurant, :beergard) }
  let(:makerd) { MakeRestaurantDetail.new(rest, 'name' => rest.company_name) }

  scenario 'restaurant specifies valid and required information' do
    visit root_path
    click_link 'Sign Up'

    click_link 'Restaurant Sign Up'

    fill_in 'First Name', with: 'firstname'
    fill_in 'Last Name', with: 'lastname'
    fill_in 'Company Name', with: 'Boston Beer Garden'
    fill_in 'Email', with: 'fake@email.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content('Account Created!')
    expect(page).to have_content('Sign Out')

    expect(page).to have_content('Boston Beer Garden')
    expect(page).to have_content('Phone: (617) 269-0990')
    expect(page).to have_content('Boston')
    expect(page).to have_content('MA')
    expect(page).to have_content('02127')
    expect(page).to have_content('734 E. Broadway')
    expect(page).to have_content('Traditional American')
    expect(page).to have_content('http://bostonbeergarden.com')
    expect(page).to have_content('Menu')
    expect(page).to have_content('Spinach and Artichoke Dip')
    expect(page).to have_content('9.99')
    expect(page).to have_content('Baby spinach, artichoke hearts, roasted red')
    expect(page).to have_content('Old Fashioned Buttermilk Pancakes')
    expect(page).to have_content('7.99')
    expect(page).to have_content('Served with warm maple syrup, butter and')
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

  scenario 'company name is a duplicate entry' do
    makerd
    visit root_path
    click_link 'Sign Up'

    click_link 'Restaurant Sign Up'

    fill_in 'First Name', with: 'firstname'
    fill_in 'Last Name', with: 'lastname'
    fill_in 'Company Name', with: 'Boston Beer Garden'
    fill_in 'Email', with: 'fake@email.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content('This venue already exists!')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'company name is too broad' do
    visit root_path
    click_link 'Sign Up'

    click_link 'Restaurant Sign Up'

    fill_in 'First Name', with: 'firstname'
    fill_in 'Last Name', with: 'lastname'
    fill_in 'Company Name', with: 'Boston'
    fill_in 'Email', with: 'fake@email.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content('Multiple venues with this company name!')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'company name does not exist' do
    visit root_path
    click_link 'Sign Up'

    click_link 'Restaurant Sign Up'

    fill_in 'First Name', with: 'firstname'
    fill_in 'Last Name', with: 'lastname'
    fill_in 'Company Name', with: 'somethingfakethatisreallyfake'
    fill_in 'Email', with: 'fake@email.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content("Company name doesn't exist!")
    expect(page).to_not have_content('Sign Out')
  end
end
