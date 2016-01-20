require 'rails_helper'

RSpec.describe RestaurantDetailSeed, type: :model, vcr: true do
  let(:restaurant) { FactoryGirl.create(:restaurant) }
  it 'populates restaurant details, opentimes, categories, and menues' do
    expect(location.data['status']).to eq('success')
  end
end
