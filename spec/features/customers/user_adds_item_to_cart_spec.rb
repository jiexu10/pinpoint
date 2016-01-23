require 'rails_helper'

feature 'user creates an order via cart', %{
  As a customer
  I want to view the menu and add items to a cart
  So that I can pick what I want from a restaurant
}, vcr: true do

  # Acceptance Criteria:
  # - [x] On the restaurant page, I should see a list of items on the menu
  # - [x] Each item should have a price displayed
  # - [x] I can create a cart from the restaurant page by selecting menu items
  # - [x] I should see a list of items and quantities in my cart
  # - [x] I should see a total price of my cart
  # - [x] A cart that is not ordered is still accessible by the customer

  let(:user) { FactoryGirl.create(:user) }
  let!(:rest1) { create_restaurant('Boston Beer Garden') }
  let!(:cart) { FactoryGirl.create(:cart, user: user, restaurant: rest1) }

  scenario 'user views restaurant page and adds items to cart' do
    user_sign_in(user)
    visit root_path
    click_link rest1.restaurantdetail.name
    price = 0.00
    rest1.items.each_with_index do |item, index|
      price += item.price.to_f
      within(".item-#{item.id}") do
        fill_in("cart_cartitems_attributes_#{index}_quantity", with: 1)
      end
    end
    click_button 'Update Cart'

    within('.cart') do
      cart = user.find_cart(rest1)
      cart.items.each do |item|
        expect(page).to have_content("#{item.name}, #{item.price} each (#{cart.find_quantity(item)})")
      end
      expect(page).to have_content(user.find_cart(rest1).find_total)
      expect(price.round(2)).to eq(user.find_cart(rest1).find_total)
    end
  end

  scenario 'user updates quantities of items in cart' do
    rest1.items.each do |item|
      Cart.add_item(cart, item, '5')
    end
    user_sign_in(user)
    visit restaurant_path(rest1)

    rest1.items.each_with_index do |item, index|
      within(".item-#{item.id}") do
        if index.even?
          fill_in("cart_cartitems_attributes_#{index}_quantity", with: 1)
        else
          fill_in("cart_cartitems_attributes_#{index}_quantity", with: 0)
        end
      end
    end
    click_button 'Update Cart'

    within('.cart') do
      rest1.items.each_with_index do |item, index|
        if index.even?
          expect(page).to have_content("#{item.name}, #{item.price} each (1)")
        else
          expect(page).to_not have_content("#{item.name}, #{item.price} each")
        end
      end
      expect(page).to have_content(user.find_cart(rest1).find_total)
    end
  end

  scenario 'logged out user cannot add items to cart' do
    visit restaurant_path(rest1)

    rest1.items.each_with_index do |item, index|
      within(".item-#{item.id}") do
        expect(page).to_not have_field("cart_cartitems_attributes_#{index}_quantity")
      end
    end
    expect(page).to_not have_selector('div.actions input')
  end
end
