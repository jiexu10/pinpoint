require 'rails_helper'

RSpec.describe MakeRestaurantDetail, type: :model, vcr: true, focus: true do
  let(:rest) { FactoryGirl.create(:restaurant) }
  it 'populates restaurant details, opentimes, categories, and menues' do
    makerd = MakeRestaurantDetail.new(rest, 'name' => "boston beer garden")
    makerd.make_detail
    restaurantdetail = makerd.rd
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

  it 'make restaurant details, hours, categories, and menus with sections' do
    makerd = MakeRestaurantDetail.new(rest, 'name' => "Betty's Wok & Noodle Diner")
    makerd.make_detail
    restaurantdetail = makerd.rd
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
