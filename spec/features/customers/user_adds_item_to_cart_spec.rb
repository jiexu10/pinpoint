require 'rails_helper'

feature 'user creates an order via cart', %{
  As a customer
  I want to add items to a cart
  So that I can order food from a restaurant
}, vcr: true, focus: true do

  # Acceptance Criteria:
  # - [ ] I can create an order from the restaurant page by selecting a menu items
  # - [ ] I should see a list of items and quantities in my order
  # - [ ] I should see a total price of my order
  # - [ ] I should see a link to place the order
  # - [ ] I should have a confirmation to place the order
  # - [ ] If an order is not confirmed, it should not be completed
  # - [ ] An order that is not confirmed is still accessible by the customer

  let (:user) { FactoryGirl.create(:user) }

  scenario 'user views restaurant page and adds items to cart' do
    rest1 = create_restaurant("Boston Beer Garden")
    user_sign_in(user)
    visit root_path
    click_link rest1.restaurantdetail.name
    price = 0.00
    n = 0
    rest1.items.each do |item|
      price += item.price.to_f
      within(".item-#{item.id}") do
        fill_in("cart_cartitems_attributes_#{n}_quantity", with: 1)
      end
      n += 1
    end
    click_button 'Add to Cart'

    within('.cart') do
      cart = user.find_cart(rest1)
      cart.items.each do |item|
        expect(page).to have_content("#{item.name}, #{item.price} each (#{user.find_cart(rest1).find_quantity(item)})")
        expect(page).to have_content(user.find_cart(rest1).find_total)
        expect(price.round(2)).to eq(user.find_cart(rest1).find_total)
      end
    end
  end

  scenario 'logged out user cannot add items to cart'
end
