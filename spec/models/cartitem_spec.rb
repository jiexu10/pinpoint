require 'rails_helper'

RSpec.describe Cartitem, type: :model, vcr: true do
  let(:user) { FactoryGirl.create(:user) }
  let(:r) { create_restaurant("Boston Beer Garden") }
  let(:cart) { FactoryGirl.create(:cart, user: user, restaurant: r) }
  let(:item) { FactoryGirl.create(:item, restaurantdetail: r.restaurantdetail) }
  let(:longnameitem) { FactoryGirl.create(:item, :longname, restaurantdetail: r.restaurantdetail) }

  it 'can pretty print an entry in the list' do
    Cart.add_item(cart, item, 1)
    Cart.add_item(cart, longnameitem, 1)

    expect(cart.cartitems[0].pp).to eq("#{item.name}, #{item.price} each (1)")
    expect(cart.cartitems[1].pp).to eq(
      "#{longnameitem.name[0..20] + '...'}, #{longnameitem.price} each (1)")
  end
end
