require 'rails_helper'

RSpec.describe Cartitem, type: :model, vcr: true, focus: true do
  let(:user) { FactoryGirl.create(:user) }
  let(:rest1) { create_restaurant("Boston Beer Garden") }
  let(:cart) { FactoryGirl.create(:cart, user: user, restaurant: rest1) }
  let(:items) { FactoryGirl.create_list(:item, 2, restaurantdetail: rest1.restaurantdetail)}

  it 'can pretty print an entry in the list' do
    Cart.add_item(cart, items[0], 1)
    expect(cart.cartitems[0].pretty_print).to eq("#{items[0].name} (1)")
  end
end
