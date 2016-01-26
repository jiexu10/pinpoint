require 'rails_helper'

RSpec.describe Seeder, type: :model, vcr: true, focus: true do
  it 'can seed the database with the expected restaurants' do
    Seeder.seed_restaurants
    expect(Restaurant.all.count).to eq(5)
    Seeder::WORKING_RESTAURANTS.each do |restaurant|
      expect(Restaurant.find_by(company_name: restaurant)).to be_a(Restaurant)
    end
  end

  it 'can seed the database with status info' do
    Seeder.seed_statuses
    expect(Status.all.count).to eq(4)
    Seeder::STATUSES.each do |status_name|
      expect(Status.find_by(name: status_name)).to be_a(Status)
    end
  end

  it 'can seed the database with a test user' do
    Seeder.seed_user
    expect(User.all.count).to eq(1)
    expect(User.first).to be_a(User)
  end

  it 'can seed the database with a test driver' do
    Seeder.seed_driver
    expect(User.all.count).to eq(1)
    expect(User.first).to be_a(User)
    expect(User.first.role).to eq('driver')
  end
end
