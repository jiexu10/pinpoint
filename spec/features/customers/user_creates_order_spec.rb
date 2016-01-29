require 'rails_helper'

feature 'user creates an order via cart', %{
  As a customer
  I want to create an order
  So that I can finalize the food that I want
}, vcr: true do

  # Acceptance Criteria:
  # - [x] I should see a link to place the order
  # - [x] After I place the order, I should see order details on order show page

  let(:user) { FactoryGirl.create(:user) }
  let(:driver) { FactoryGirl.create(:user, :driver) }
  let!(:rest1) { create_restaurant('Boston Beer Garden') }
  let(:cart) { FactoryGirl.create(:cart, user: user, restaurant: rest1) }
  let!(:statuses) { create_statuses }

  scenario 'user has a cart and places an order' do
    rest1.items.each do |item|
      unless item.price == 'No Price'
        Cart.add_item(cart, item, '5')
      end
    end
    user_sign_in(user)
    visit restaurantdetail_path(rest1.restaurantdetail)
    click_button 'Place Order'

    expect(page).to have_content('Order Placed!')
    expect(page).to have_content('Order Status: Pending')
    within('.cart') do
      rest1.items.each do |item|
        unless item.price == 'No Price'
          expect(page).to have_content(
          "#{item.truncate}, #{item.price} each (#{cart.find_quantity(item)})")
        end
      end
      expect(page).to have_content(user.find_cart(rest1).find_total)
    end
  end

  scenario 'user places an order, then later places order at same place' do
    rest1.items.each do |item|
      unless item.price == 'No Price'
        Cart.add_item(cart, item, '5')
      end
    end
    create_orders_from_carts([cart], driver)
    user_sign_in(user)

    cart2 = FactoryGirl.create(:cart, user: user, restaurant: rest1)
    rest1.items.each do |item|
      unless item.price == 'No Price'
        Cart.add_item(cart2, item, '5')
      end
    end
    visit restaurantdetail_path(rest1.restaurantdetail)
    click_button 'Place Order'

    expect(page).to have_content('Order Placed!')
    expect(page).to have_content('Order Status: Pending')
    within('.cart') do
      rest1.items.each do |item|
        unless item.price == 'No Price'
          expect(page).to have_content(
          "#{item.truncate}, #{item.price} each (#{cart.find_quantity(item)})")
        end
      end
      expect(page).to have_content(user.find_cart(rest1).find_total)
    end
  end

  scenario 'user adds invalid items to order' do
    rest1.items.each do |item|
        Cart.add_item(cart, item, '5')
    end
    user_sign_in(user)
    visit restaurantdetail_path(rest1.restaurantdetail)
    click_button 'Place Order'

    expect(page).to have_content('Please remove items with no price.')
    expect(page).to have_content(rest1.restaurantdetail.name)
  end
end
