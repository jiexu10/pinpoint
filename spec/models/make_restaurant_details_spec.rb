require 'rails_helper'

RSpec.describe MakeRestaurantDetail, type: :model, vcr: true do
  let(:rest) { FactoryGirl.create(:restaurant) }
  it 'populates restaurant details, opentimes, categories, and menues'do
    makerd = MakeRestaurantDetail.new(rest, 'name' => "boston beer garden")
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

  it 'make restaurant details with delivery data' do
    makerd = MakeRestaurantDetail.new(rest, 'name' => "Siam Bistro")
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
    expect(restaurantdetail.delivery).to eq("true")
  end

  it 'raises VenueExistsError when attemptning to add restaurant that exists' do
    MakeRestaurantDetail.new(rest, 'name' => "Siam Bistro")
    makerd = MakeRestaurantDetail.new(rest, 'name' => "Siam Bistro")
    expect(makerd.valid?).to eq(false)

  end

  it 'raises MultipleVenueError when the query is too broad' do
    makerd = MakeRestaurantDetail.new(rest, 'locality' => "Boston")
    expect(makerd.valid?).to eq(false)
  end
end
