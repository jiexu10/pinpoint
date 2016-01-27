require 'rails_helper'

RSpec.describe Cart, type: :model, vcr: true do
  let(:user) { FactoryGirl.create(:user) }
  let(:rest) { create_restaurant("Boston Beer Garden") }
  let(:cart) { FactoryGirl.create(:cart, user: user, restaurant: rest) }
  let(:items) { FactoryGirl.create_list(:item, 2, restaurantdetail: rest.restaurantdetail) }

  it 'can add an item to a cart' do
    Cart.add_item(cart, items[0], '1')
    expect(cart.cartitems.count).to eq(1)
    expect(cart.items.count).to eq(1)
    expect(cart.find_total).to eq(items[0].price)
  end

  it 'can calculate the total price correctly' do
    Cart.add_item(cart, items[0], '1')
    Cart.add_item(cart, items[1], '2')
    expect(cart.cartitems.count).to eq(2)
    expect(cart.items.count).to eq(2)
    expect(cart.find_total).to eq((items[0].price.to_f + items[1].price.to_f * 2).to_s)
  end

  it 'can find the quantity of an item' do
    Cart.add_item(cart, items[0], '1')
    Cart.add_item(cart, items[1], '2')
    expect(cart.find_quantity(items[0])).to eq('1')
    expect(cart.find_quantity(items[1])).to eq('2')
  end
end
