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

  let(:rest) { create_restaurant('Boston Beer Garden') }
  let(:carts) { FactoryGirl.create_list(:cart, 4, restaurant: rest) }
  let!(:statuses) { create_statuses }

  scenario 'restaurant logs in and sees pending and completed orders' do
    create_orders_from_carts(carts)

    pend_status = Status.find_by(name: 'Pending')
    comp_status = Status.find_by(name: 'Complete')
    rest_orders = Order.where(restaurant: rest).order(created_at: :asc)
    comp_orders = [rest_orders.first, rest_orders.last]
    comp_orders.each { |ord| ord.update_attributes(status: comp_status) }
    pend_orders = Order.where(restaurant: rest, status: pend_status).order(created_at: :asc)

    restaurant_sign_in(rest)

    within('.pending-order-column') do
      pend_orders.each do |order|
        expect(page).to have_content("Order ID: ##{order.id}")
        order.items.each do |item|
          expect(page).to have_content(item.name)
          expect(page).to have_content(order.cart.find_quantity(item))
        end
      end

      comp_orders.each do |order|
        expect(page).to_not have_content("Order ID: ##{order.id}")
      end

      expect("Order ID: ##{pend_orders.first.id}").to appear_before("Order ID: ##{pend_orders.last.id}")
    end

    within('.complete-order-column') do
      comp_orders.each do |order|
        expect(page).to have_content("Order ID: ##{order.id}")
        order.items.each do |item|
          expect(page).to have_content(item.name)
          expect(page).to have_content(order.cart.find_quantity(item))
        end
      end

      pend_orders.each do |order|
        expect(page).to_not have_content("Order ID: ##{order.id}")
      end

      expect("Order ID: ##{comp_orders.last.id}").to appear_before("Order ID: ##{comp_orders.first.id}")
    end
  end
end
