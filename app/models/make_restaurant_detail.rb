class MakeRestaurantDetail
  attr_reader :venue, :rd, :exists_valid, :multiple_valid, :match_valid

  def initialize(rest, query = {})
    locu_data = LocuData.new(query)
    locu_data.search_function
    raw_data_body = locu_data.data.body
    @data = JSON.parse(raw_data_body)
    @exists_valid = true
    @multiple_valid = true
    @match_valid = true
    if @data['venues'].count == 1
      @venue = @data['venues'][0]
      if Restaurantdetail.find_by(locuid: venue['locu_id']).nil?
        @rd = Restaurantdetail.new
        rd.restaurant = rest
        make_detail
      else
        @exists_valid = false
      end
    # binding.pry
    # if @data['venues'].count == 1 || query_name_exact_match?(query)
    #   binding.pry
    #   if @data['venues'].count == 1
    #     @venue = @data['venues'][0]
    #   elsif query_name_exact_match?(query)
    #     binding.pry
    #     @venue = @data['venues'].select { |place| place['name'] == query['name'] }
    #   end
    #   if Restaurantdetail.find_by(locuid: venue['locu_id']).nil?
    #     @rd = Restaurantdetail.new
    #     rd.restaurant = rest
    #     make_detail
    #   else
    #     @exists_valid = false
    #   end
    elsif @data['venues'].empty?
      @match_valid = false
    else
      @multiple_valid = false
    end
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
      rd.delivery = venue['delivery']['will_deliver'].to_s
    end
    if rd.save
      make_categories(rd) if venue['categories']
      make_opentimes(rd) if venue['open_hours']
      make_menu(rd) if venue['menus']
    end
  end

  def make_categories(rd)
    venue['categories'].each do |category|
      cat = Category.find_or_create_by(str_id: category['str_id']) do |new_cat|
        new_cat.name = category['name']
      end
      Restaurantcategory.find_or_create_by(restaurantdetail: rd, category: cat)
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
    venue['menus'].each do |menu|
      ms = nil
      if !menu['menu_name'].blank?
        ms = Menusection.find_or_create_by(restaurantdetail: rd, name: menu['menu_name'])
      end
      menu['sections'].each do |subsec|
        subsec['subsections'].each do |subsection|
          subsection['contents'].each do |it|
            Item.find_or_create_by(restaurantdetail: rd, name: it['name']) do |mi|
              mi.menusection = ms
              mi.price = it['price']
              mi.description = it['description'] if it['description']
            end
          end
        end
      end
    end
  end

  def valid?
    @exists_valid && @multiple_valid && @match_valid
  end

  # def query_name_exact_match?(query)
  #   @data['venues'].select { |place| place['name'] == query['name'] }.count == 1
  # end
end
