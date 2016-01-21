class MakeRestaurantDetail
  attr_reader :venue, :rd

  def initialize(restaurant, query = {})
    locu_data = LocuData.new(query)
    locu_data.search_function
    raw_data_body = locu_data.data.body
    @restaurant = restaurant
    @data = JSON.parse(raw_data_body)
    if @data['venues'].count == 1
      @venue = @data['venues'][0]
    else
      raise MultipleVenueError
    end
    @rd = Restaurantdetail.new
    make_detail
  end

  def make_detail
    rd.name = venue['name']
    rd.description = venue['description']
    rd.locuid = venue['locu_id']
    rd.phone = venue['contact']['phone']
    rd.website_url = venue['website_url']
    rd.address_one = venue['location']['address1']
    rd.address_two = venue['location']['address2']
    rd.city = venue['location']['locality']
    rd.state = venue['location']['region']
    rd.zip_code = venue['location']['postal_code']
    rd.coordinates = venue['location']['geo']['coordinates'].to_s
    if venue['delivery']
      rd.delivery = venue['delivery']['will deliver'].to_s
    end
    if rd.save
      make_categories(rd) if venue['categories']
      make_opentimes(rd) if venue['open_hours']
      make_menu(rd) if venue['menus']
    else
    end
  end

  def make_categories(rd)
    venue['categories'].each do |category|
      cat = Category.find_or_create_by(str_id: category['str_id']) do |new_cat|
        new_cat.name = category['name']
      end
      Restaurantcategory.create(restaurantdetail: rd, category: cat)
    end
  end

  def make_opentimes(rd)
    venue['open_hours'].each do |key, value|
      Opentime.find_or_create_by(day: key) do |new_time|
        new_time.restaurantdetail = rd
        new_time.open_hour = value[0].first
        new_time.close_hour = value[0].last
      end
    end
  end

  def make_menu(rd)
    venue['menus'].first['sections'].each do |subsec|
      subsec['subsections'].each do |subsection|
        ms = nil
        if !subsection['subsection_name'].blank?
          ms = Menusection.find_or_create_by(restaurantdetail: rd, name: subsection['subsection_name'])
        end
        subsection['contents'].each do |it|
          Item.find_or_create_by(restaurantdetail: rd, name: it['name']) do |mi|
            mi.price = it['price']
            mi.description = it['description'] if it['description']
          end
        end
      end
    end
  end
end

class MultipleVenueError < StandardError
end
