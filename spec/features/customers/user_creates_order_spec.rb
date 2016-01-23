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
  let!(:rest1) { create_restaurant('Boston Beer Garden') }
  let!(:cart) { FactoryGirl.create(:cart, user: user, restaurant: rest1) }

  scenario 'user has a cart and places an order' do
    rest1.items.each do |item|
      Cart.add_item(cart, item, '5')
    end
    user_sign_in(user)
    visit restaurant_path(rest1)
    click_button 'Place Order'

    expect(page).to have_content('Order Placed!')
    expect(page).to have_content('Order Status: Pending')
    within('.cart') do
      rest1.items.each do |item|
        expect(page).to have_content("#{item.name}, #{item.price} each (#{cart.find_quantity(item)})")
      end
      expect(page).to have_content(user.find_cart(rest1).find_total)
    end
  end
end
