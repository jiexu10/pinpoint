require 'rails_helper'

RSpec.describe Api::V1::UsersController, vcr: true do
  let!(:driver) { FactoryGirl.create(:user, :driver) }

  it 'can retrieve latitude and longitude data' do
    driver.update_attributes(latitude: 42.3456789, longitude: -67.8912345)
    expect(driver.valid?).to eq(true)

    new_lat = "12.3456789"
    new_lng = "23.4567891"
    params = { id: driver.id, lat: new_lat, lng: new_lng }
    patch "/api/v1/users/#{driver.id}", params, format: :json

    json = JSON.parse(response.body)
    expect(json['lat']).to eq(new_lat)
    expect(json['lng']).to eq(new_lng)
  end
end
