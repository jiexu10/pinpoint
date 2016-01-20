require 'rails_helper'

RSpec.describe LocuData, type: :model, vcr: true do
  it 'successfully receives json data from locu with default parameters' do
    locu_data = LocuData.new
    locu_data.search_function
    expect(locu_data.data['status']).to eq('success')
    locu_data.data['venues'].each do |venue|
      expect(venue['location']['locality']).to eq(IpApi.new.data['city'])
      expect(venue['categories'].any? { |category| category['str_id'] == 'restaurants' }).to eq(true)
    end
  end

  it 'can search by name' do
    locu_data = LocuData.new( { 'name' => 'bistro central parc'} )
    locu_data.search_function
    expect(locu_data.data['venues'].count).to eq(1)
    expect(locu_data.data['venues'][0]['locu_id']).to eq('3ac33e6306c52465e30a')
    expect(locu_data.data['venues'][0]['name']).to eq('Bistro Central Parc')
  end

  it 'can search by open times' do
    locu_data = LocuData.new( { 'open_hours' => { 'monday' => ['18:00'] } } )
    t = Time.local(2016, 1, 19, 18, 0, 0)
    locu_data.search_function
    locu_data.data['venues'].each do |venue|
      expect(venue['open_hours'].has_key?('monday')).to eq(true)
      expect(venue['open_hours']['monday'][0][0].to_i).to be <= t.strftime("%H").to_i
    end
  end

  it 'can search by location, locality' do
    locu_data = LocuData.new( { 'location' => { 'locality' => 'Cambridge' } } )
    locu_data.search_function
    locu_data.data['venues'].each do |venue|
      expect(venue['location']['locality']).to eq('Cambridge')
    end
  end


  it 'can search by location, postal code' do
    locu_data = LocuData.new( { 'location' => { 'postal_code' => '02111' } } )
    locu_data.search_function
    locu_data.data['venues'].each do |venue|
      expect(venue['location']['postal_code']).to eq('02111')
    end
  end

  it 'can search by location, latitude-longitude-radius' do
    locu_data = LocuData.new( { 'location' => { 'lat_lng_radius' => [42.359464, -71.061292, 500] } } )
    locu_data.search_function
    locu_data.data['venues'].each do |venue|
      expect(venue['location']['locality']).to satisfy("be in Boston or Cambridge") do |location|
        location == 'Boston' || location == 'Cambridge' || location == 'Dorchester'
      end
    end
  end

  it 'can search by menu' do
    locu_data = LocuData.new( { 'menus' => true } )
    locu_data.search_function
    locu_data.data['venues'].each do |venue|
      expect(venue.has_key?('menus')).to eq(true)
    end
  end

  it 'can search by categories' do
    locu_data = LocuData.new( { 'categories' => 'pizza' } )
    locu_data.search_function
    locu_data.data['venues'].each do |venue|
      expect(venue['categories'].any? { |category| category['str_id'] == 'pizza' }).to eq(true)
      expect(venue['categories'].any? { |category| category['str_id'] == 'restaurants' }).to eq(true)
    end
  end
end
