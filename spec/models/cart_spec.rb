require 'rails_helper'

RSpec.describe Cart, type: :model, vcr: true do
  let(:user) { FactoryGirl.create(:user) }
  let(:rest1) { create_restaurant("Boston Beer Garden") }
  let(:cart) { FactoryGirl.create(:cart, user: user, restaurant: rest1) }
  let(:items) { FactoryGirl.create_list(:item, 2, restaurantdetail: rest1.restaurantdetail)}

  it 'can add an item to a cart' do
    Cart.add_item(cart, items.first, '1')
    expect(cart.cartitems.count).to eq(1)
    expect(cart.items.count).to eq(1)
    expect(cart.find_total).to eq(items.first.price.to_f)
  end

  it 'can calculate the total price correctly' do
    Cart.add_item(cart, items.first, '1')
    Cart.add_item(cart, items.last, '2')
    expect(cart.cartitems.count).to eq(2)
    expect(cart.items.count).to eq(2)
    expect(cart.find_total).to eq(items.first.price.to_f + items.last.price.to_f * 2)
  end

  it 'can find the quantity of an item' do
    Cart.add_item(cart, items.first, '1')
    Cart.add_item(cart, items.last, '2')
    expect(cart.find_quantity(items.first)).to eq('1')
    expect(cart.find_quantity(items.last)).to eq('2')
  end
end
