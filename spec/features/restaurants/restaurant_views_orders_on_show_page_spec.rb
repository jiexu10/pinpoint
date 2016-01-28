require 'rails_helper'

feature 'restaurant views orders on show page', %{
  As a restaurant
  I want to see all open orders
  So that I know food to make
}, vcr: true do

  # Acceptance Criteria:
  # - [x] On login as a restaurant, I should be brought to an order index page
  # - [x] Orders should be sorted by status
  # - [x] Orders should be sorted by time

  let(:driver) { FactoryGirl.create(:user, :driver) }
  let(:user) { FactoryGirl.create(:user) }
  let(:rest) { create_restaurant('Boston Beer Garden') }
  let(:rest2) { create_restaurant('Siam Bistro') }
  let(:carts) { FactoryGirl.create_list(:cart, 4, restaurant: rest) }
  let!(:statuses) { create_statuses }

  scenario 'restaurant logs in and sees pending and completed orders' do
    create_orders_from_carts(carts, driver)

    pending = Status.find_by(name: 'Pending')
    complete = Status.find_by(name: 'Complete')
    rest_orders = Order.where(restaurant: rest).order(created_at: :asc)
    comp_orders = [rest_orders.first, rest_orders.last]
    comp_orders.each { |ord| ord.update_attributes(status: complete) }
    pend_orders = Order.where(restaurant: rest, status: pending).order(created_at: :asc)

    restaurant_sign_in(rest)

    within('.pending-order-column') do
      pend_orders.each do |order|
        verify_order(order)
      end

      comp_orders.each do |order|
        expect(page).to_not have_content("Order ID: ##{order.id}")
      end

      expect("Order ID: ##{pend_orders.first.id}").to appear_before("Order ID: ##{pend_orders.last.id}")
    end

    within('.complete-order-column') do
      comp_orders.each do |order|
        verify_order(order)
      end

      pend_orders.each do |order|
        expect(page).to_not have_content("Order ID: ##{order.id}")
      end

      expect("Order ID: ##{comp_orders.last.id}").to appear_before("Order ID: ##{comp_orders.first.id}")
    end
  end

  scenario 'restaurant cannot view other restaurant show page' do
    restaurant_sign_in(rest2)
    visit restaurant_path(rest)

    expect(page).to have_content('Action not permitted.')
  end

  scenario 'user cannot view other restaurant show page' do
    user_sign_in(user)
    visit restaurant_path(rest)

    expect(page).to have_content('Action not permitted.')
  end

  scenario 'logged out user cannot view restaurant show page' do
    visit restaurant_path(rest)

    expect(page).to have_content('Action not permitted.')
  end
end
