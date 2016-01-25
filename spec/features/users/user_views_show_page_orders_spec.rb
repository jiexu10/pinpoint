require 'rails_helper'

feature 'user views orders on user show page', %{
  As a customer
  I want to see all my orders
  So I can view my history
}, vcr: true, focus: true do

  # Acceptance Criteria:
  # - [x] I can navigate to an index of orders from the root page
  # - [x] The orders should be sorted by date
  # - [x] Orders that are pending should appear first in the list

  let(:user) { FactoryGirl.create(:user) }
  let!(:rest1) { create_restaurant('Boston Beer Garden') }
  let!(:rest2) { create_restaurant('Morse Fish Company') }
  let!(:rest3) { create_restaurant('Siam Bistro') }
  let!(:cart1) { FactoryGirl.create(:cart, user: user, restaurant: rest1) }
  let!(:cart2) { FactoryGirl.create(:cart, user: user, restaurant: rest2) }
  let!(:cart3) { FactoryGirl.create(:cart, user: user, restaurant: rest3) }

  scenario 'user views the order list' do
    rest1.items.each do |item|
      Cart.add_item(cart1, item, '5')
    end
    rest2.items.each do |item|
      Cart.add_item(cart2, item, '5')
    end
    rest3.items.each do |item|
      Cart.add_item(cart3, item, '5')
    end
    orders = [
      create_order(cart1, rest1, user),
      create_order(cart2, rest2, user),
      create_order(cart3, rest3, user)
    ]
    orders.first.update_attributes(order_status: 'Completed')
    orders[1].update_attributes(order_status: 'Completed')
    user_sign_in(user)
    click_link "Welcome, #{user.first_name}!"

    expect(Order.all.count).to eq(3)
    within('.pending-order-list') do
      expect(page).to have_content(orders.last.user.full_name)
      expect(page).to have_content(orders.last.restaurant.company_name)
      expect(page).to have_content(orders.last.id)
    end
    within('.completed-order-list') do
      expect(page).to have_content(orders.first.user.full_name)
      expect(page).to have_content(orders.first.restaurant.company_name)
      expect(page).to have_content(orders.first.id)
    end
    expect(orders.last.restaurant.company_name).to appear_before(orders.first.restaurant.company_name)
    expect(orders[1].restaurant.company_name).to appear_before(orders.first.restaurant.company_name)
  end

  scenario 'logged out user cannot view show page' do
    visit user_path(user)

    expect(page).to have_content("You need to sign in before continuing!")
    expect(page).to_not have_css('.pending-order-list')
    expect(page).to_not have_css('.order-list')
  end
end
