require 'rails_helper'

feature 'user signs out', %{
  As a customer
  I want to browse the available restaurants
  So that I can see what is available to eat
} do

  # Acceptance Criteria:
  # - [ ] I should see a list of restaurants on the root page
  # - [ ] I should see what kind of food each restaurant serves
  # - [ ] I should see the address of the restaurant
  # - [ ] The restaurants should default to be nearby to my location

  let (:user) { FactoryGirl.create(:user) }
  let (:restaurant) { FactoryGirl.create(:restaurant) }

  scenario 'logged out user views the home page and sees required information'

  scenario 'logged in user is brought back to home page on log in'
end
