require 'rails_helper'

feature 'restaurant changes orders from show page', %{
  As a restaurant
  I want to be able to change the status on orders
  So I can keep track of what is done and what orders need to be filled
}, vcr: true, focus: true do

  # Acceptance Criteria:
  # - [ ] On the order index page, I should see a button to change order status
  # - [ ] When I click the button to change order status, it should change
  # - [ ] When clicking on one order, other orders should not change

  let(:rest) { create_restaurant('Boston Beer Garden') }
  let(:carts) { FactoryGirl.create_list(:cart, 2, restaurant: rest) }
  let!(:statuses) { create_statuses }

  scenario 'restaurant can change order status on their orders' do
    create_orders_from_carts(carts)
    orders = Order.all

    restaurant_sign_in(rest)
    visit restaurant_path(rest)
    expect(orders.count).to eq(2)
    orders.each do |order|
      within('.pending-order-column') do
        within(".order-id-#{order.id}") do
          click_button 'Move Right'
        end
      end
      expect(page).to have_content('Order Updated!')
      within('.confirmed-order-column') do
        within(".order-id-#{order.id}") do
          expect(page).to have_content("Order ID: ##{order.id}")
          order.items.each do |item|
            expect(page).to have_content(item.name)
            expect(page).to have_content(order.cart.find_quantity(item))
          end
        end
      end
    end
  end
end
