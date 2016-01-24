require 'rails_helper'

feature 'user sees restaurant index', %{
  As a customer
  I want to browse the available restaurants
  So that I can see what is available to eat
}, vcr: true do

  # Acceptance Criteria:
  # - [x] I should see a list of restaurants on the root page
  # - [x] I should see what kind of food each restaurant serves
  # - [x] I should see the address of the restaurant

  let (:user) { FactoryGirl.create(:user) }

  scenario 'user views the home page and sees required info' do
    restaurant1 = create_restaurant("Boston Beer Garden")
    restaurant2 = create_restaurant("Morse Fish Company")
    visit root_path

    [restaurant1, restaurant2].each do |restaurant|
      within(".restaurant-info-#{restaurant.id}") do
        expect(page).to have_content(restaurant.restaurantdetail.name)
        expect(page).to have_content(restaurant.restaurantdetail.address_one)
        expect(page).to have_content(restaurant.restaurantdetail.city)
        expect(page).to have_content(restaurant.restaurantdetail.state)
        expect(page).to have_content(restaurant.restaurantdetail.zip_code)
        expect(page).to have_content(restaurant.restaurantdetail.phone)
        restaurant.categories.each do |category|
          unless category.name == "Restaurants"
            expect(page).to have_content(category.name)
          end
        end
      end
    end
  end
end
