require 'rails_helper'

RSpec.describe Cart, type: :model, focus: true do
  let(:user) { FactoryGirl.create(:user) }
  let(:restaurant) { FactoryGirl.create(:restaurant) }
  let(:item) { FactoryGirl.create(:item) }
  let(:cart) { FactoryGirl.create(:cart, user: user, restaurant: restaurant) }

  it 'can add an item to a cart' do
    Cart.add_item(cart, item, 1)
    expect(cart.items.count).to eq(1)
    expect(cart.find_total).to eq(item.price)
  end
end
