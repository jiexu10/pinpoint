require 'rails_helper'

RSpec.describe Cartitem, type: :model, vcr: true do
  let(:user) { FactoryGirl.create(:user) }
  let(:rest1) { create_restaurant("Boston Beer Garden") }
  let(:cart) { FactoryGirl.create(:cart, user: user, restaurant: rest1) }
  let(:item) { FactoryGirl.create(:item, restaurantdetail: rest1.restaurantdetail)}

  it 'can pretty print an entry in the list' do
    Cart.add_item(cart, item, 1)
    expect(cart.cartitems[0].pretty_print).to eq("#{item.name}, #{item.price} each (1)")
  end
end
