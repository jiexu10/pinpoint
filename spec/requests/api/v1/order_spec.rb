require 'rails_helper'

RSpec.describe Api::V1::OrdersController, vcr: true do
  let(:driver) { FactoryGirl.create(:user, :driver) }
  let(:restaurant) { create_restaurant('Boston Beer Garden') }
  let(:cart) { FactoryGirl.create(:cart, restaurant: restaurant) }
  let!(:statuses) { create_statuses }
  let!(:create_orders) { create_orders_from_carts([cart], driver) }
  let!(:order) { Order.first }

  it 'can retrieve restaurant latitude and longitude data from an order' do
    params = { id: order.id, request: 'restaurant' }
    get "/api/v1/orders/#{order.id}", params, format: :json

    json = JSON.parse(response.body)
    coord = restaurant.restaurantdetail.coordinates
    parse_coord = coord.match(/\[(\S+), (\S+)\]/)
    expect(json['lat'].to_s).to eq(parse_coord[2])
    expect(json['lng'].to_s).to eq(parse_coord[1])
  end

  it 'can retrieve restaurant latitude and longitude data from an order' do
    driver.update_attributes(latitude: 12.3456789, longitude: 23.4567891)
    expect(driver.valid?).to eq(true)

    params = { id: order.id, request: 'driver' }
    get "/api/v1/orders/#{order.id}", params, format: :json

    json = JSON.parse(response.body)
    expect(json['lat']).to eq(driver.latitude.to_f)
    expect(json['lng']).to eq(driver.longitude.to_f)
  end
end
