require 'rails_helper'

feature 'user views orders on user show page', %{
  As a customer
  I want to see all my orders
  So I can view my history
}, vcr: true do

  # Acceptance Criteria:
  # - [x] I can navigate to an index of orders from the root page
  # - [x] The orders should be sorted by date
  # - [x] Orders that are pending should appear first in the list

  let(:user) { FactoryGirl.create(:user) }
  let(:rest1) { create_restaurant('Boston Beer Garden') }
  let(:rest2) { create_restaurant('Morse Fish Company') }
  let(:rest3) { create_restaurant('Siam Bistro') }
  let!(:cart1) { FactoryGirl.create(:cart, user: user, restaurant: rest1) }
  let!(:cart2) { FactoryGirl.create(:cart, user: user, restaurant: rest2) }
  let!(:cart3) { FactoryGirl.create(:cart, user: user, restaurant: rest3) }
  let!(:statuses) { create_statuses }

  scenario 'user views the order list' do
    carts = [cart1, cart2, cart3]
    create_orders_from_carts(carts)
    orders = Order.all
    completed_status = Status.find_by(name: 'Complete')
    orders[0].update_attributes(status: completed_status)
    orders[1].update_attributes(status: completed_status)
    user_sign_in(user)
    click_link "Welcome, #{user.first_name}!"

    expect(Order.all.count).to eq(3)
    within('.pending-order-list') do
      expect(page).to have_content(orders.last.user.full_name)
      expect(page).to have_content(orders.last.restaurant.company_name)
      expect(page).to have_content(orders.last.id)
      expect(page).to have_content(orders.last.status.name)
    end
    within('.completed-order-list') do
      expect(page).to have_content(orders.first.user.full_name)
      expect(page).to have_content(orders.first.restaurant.company_name)
      expect(page).to have_content(orders.first.id)
      expect(page).to have_content(orders.first.status.name)
    end
    expect(rest3.company_name).to appear_before(rest1.company_name)
    expect(rest2.company_name).to appear_before(rest1.company_name)
  end

  scenario 'logged out user cannot view the order show page' do
    create_orders_from_carts([cart1])
    order = Order.first
    visit order_path(order)

    expect(page).to have_content('Action not permitted.')
  end

  scenario 'logged out user cannot view user show page' do
    visit user_path(user)

    expect(page).to have_content("You need to sign in before continuing!")
    expect(page).to_not have_css('.pending-order-list')
    expect(page).to_not have_css('.completed-order-list')
  end
end
