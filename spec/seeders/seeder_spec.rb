require 'rails_helper'

RSpec.describe Seeder, type: :model, vcr: true do
  it 'can seed the database with the expected information' do
    Seeder.seed_restaurants
    expect(Restaurant.all.count).to eq(5)
    Seeder::WORKING_RESTAURANTS.each do |restaurant|
      expect(Restaurant.find_by(company_name: restaurant)).to be_a(Restaurant)
    end
  end
end
