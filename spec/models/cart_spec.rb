require 'rails_helper'

RSpec.describe Cart, type: :model, vcr: true do
  let(:user) { FactoryGirl.create(:user) }
  let(:rest1) { create_restaurant("Boston Beer Garden") }
  let(:cart) { FactoryGirl.create(:cart, user: user, restaurant: rest1) }
  let(:items) { FactoryGirl.create_list(:item, 2, restaurantdetail: rest1.restaurantdetail)}

  it 'can add an item to a cart' do
    item = items[0]
    Cart.add_item(cart, item, 1)
    expect(cart.cartitems.count).to eq(1)
    expect(cart.items.count).to eq(1)
    expect(cart.find_total).to eq(item.price.to_f)
  end

  it 'can calculate the total price correctly' do
    Cart.add_item(cart, items[0], 1)
    Cart.add_item(cart, items[1], 2)
    expect(cart.cartitems.count).to eq(2)
    expect(cart.items.count).to eq(2)
    expect(cart.find_total).to eq(items[0].price.to_f * 3)
  end
end
