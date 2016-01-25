require 'rails_helper'

feature 'restaurant changes orders from show page', %{
  As a restaurant
  I want to be able to change the status on orders
  So I can keep track of what is done and what orders need to be filled
}, vcr: true do

  # Acceptance Criteria:
  # - [x] On the order index page, I should see a button to change order status
  # - [x] When I click the button to change order status, it should change
  # - [x] When clicking on one order, other orders should not change

  let(:rest) { create_restaurant('Boston Beer Garden') }
  let(:carts) { FactoryGirl.create_list(:cart, 2, restaurant: rest) }
  let!(:statuses) { create_statuses }

  scenario 'restaurant can change order status on their orders' do
    create_orders_from_carts(carts)
    orders = Order.all

    restaurant_sign_in(rest)
    visit restaurant_path(rest)
    expect(orders.count).to eq(2)

    columns = [
      '.pending-order-column',
      '.confirmed-order-column',
      '.delivery-order-column',
      '.complete-order-column'
    ]
    orders.each do |order|
      first_three_columns = columns[0..2]
      first_three_columns.each do |column|
        within(column) do
          within(".order-id-#{order.id}") do
            verify_order(order)
            click_button 'Move Right'
          end
        end
      end

      expect(page).to have_content('Order Updated!')
      within('.complete-order-column') do
        within(".order-id-#{order.id}") do
          verify_order(order)
        end
      end
    end

    orders.each do |order|
      last_three_columns = columns[1..3].reverse
      last_three_columns.each do |column|
        within(column) do
          within(".order-id-#{order.id}") do
            verify_order(order)
            click_button 'Move Left'
          end
        end
      end

      expect(page).to have_content('Order Updated!')
      within('.pending-order-column') do
        within(".order-id-#{order.id}") do
          verify_order(order)
        end
      end
    end
  end

end
