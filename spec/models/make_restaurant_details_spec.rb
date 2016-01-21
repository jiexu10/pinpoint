require 'rails_helper'

RSpec.describe MakeRestaurantDetail, type: :model, vcr: true, focus: true do
  let(:restaurant) { FactoryGirl.create(:restaurant) }
  it 'populates restaurant details, opentimes, categories, and menues' do
    makerestaurantdetail = MakeRestaurantDetail.new(restaurant, 'name' => "boston beer garden")
    makerestaurantdetail.make_detail
    restaurantdetail = makerestaurantdetail.rd
    expect(restaurantdetail).to be_a(Restaurantdetail)
    restaurantdetail.opentimes.each do |time|
      expect(time).to be_a(Opentime)
    end
    restaurantdetail.restaurantcategories.each do |restaurantcategory|
      expect(restaurantcategory).to be_a(Restaurantcategory)
    end
    restaurantdetail.categories.each do |category|
      expect(category).to be_a(Category)
    end
    restaurantdetail.menusections.each do |menusection|
      expect(menusection).to be_a(Menusection)
    end
    restaurantdetail.items.each do |item|
      expect(item).to be_a(Item)
    end
  end

  it 'raises MultipleVenueError when the query is too broad' do
    expect { MakeRestaurantDetail.new('locality' => "Boston") }.to raise_error(MultipleVenueError)
  end
end
