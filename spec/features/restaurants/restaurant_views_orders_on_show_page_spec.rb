require 'rails_helper'

feature 'restaurant views orders on show page', %{
  As a restaurant
  I want to see all open orders
  So that I know food to make
}, vcr: true, focus: true do

  # Acceptance Criteria:
  # - [x] On login as a restaurant, I should be brought to an order index page
  # - [x] Orders should be sorted by status
  # - [x] Orders should be sorted by time

  let(:rest) { create_restaurant('Boston Beer Garden') }
  let(:carts) { FactoryGirl.create_list(:cart, 4, restaurant: rest) }

  scenario 'restaurant logs in and sees pending and completed orders' do
    carts.each do |cart|
      rest.items.each do |item|
        Cart.add_item(cart, item, '5')
      end
      create_order(cart, rest, cart.user)
    end

    rest_orders = Order.where(restaurant: rest).order(created_at: :asc)
    comp_orders = [rest_orders.first, rest_orders.last]
    comp_orders.each { |ord| ord.update_attributes(order_status: 'Completed') }
    pend_orders = Order.where(restaurant: rest, order_status: 'Pending').order(created_at: :asc)

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

    within('.completed-order-column') do
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
