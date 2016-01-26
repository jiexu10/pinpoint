require 'rails_helper'

feature 'user views orders on user show page', %{
  As a driver
  I want to see all open orders
  So I know what I need to deliver
}, vcr: true do

  # Acceptance Criteria:
  # - [ ] On login as a driver, I should be brought to an order index page
  # - [ ] Orders should be sorted by status
  # - [ ] Orders should be sorted by time, oldest first

  let(:driver) { FactoryGirl.create(:user, :driver) }
  let(:rest) { create_restaurant('Boston Beer Garden') }
  let!(:carts) { FactoryGirl.create_list(:cart, 4, restaurant: rest) }
  let!(:statuses) { create_statuses }

  scenario 'driver views the order list on user show page' do
    create_orders_from_carts(carts)
    orders = Order.all
    completed_status = Status.find_by(name: 'Complete')
    orders[0].update_attributes(driver: driver, status: completed_status)
    orders[1].update_attributes(driver: driver)
    orders[2].update_attributes(driver: driver)
    pending_orders = orders[1..2]
    user_sign_in(driver)
    click_link "Welcome, #{driver.first_name}!"

    expect(Order.all.count).to eq(4)
    expect(page).to have_content('Show My Location')
    within('.pending-order-list') do
      pending_orders.each do |order|
        expect(page).to have_content(order.user.full_name)
        expect(page).to have_content(order.restaurant.company_name)
        expect(page).to have_content(order.id)
        expect(page).to have_content(order.status.name)
      end
      expect(page).to_not have_content(orders.last.user.full_name)
      expect(pending_orders.last.user.full_name).to appear_before(pending_orders.first.user.full_name)
    end
    within('.completed-order-list') do
      expect(page).to have_content(orders.first.user.full_name)
      expect(page).to have_content(orders.first.restaurant.company_name)
      expect(page).to have_content(orders.first.id)
      expect(page).to have_content(orders.first.status.name)
    end
  end
end
