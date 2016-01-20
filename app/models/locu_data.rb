class LocuData
  include HTTParty
  attr_reader :data, :name, :location, :categories, :open_hours, :menus
  attr_accessor :venue_queries

  def initialize(query = {})
    @name = query['name']
    @location = query['location']
    @categories = query['categories']
    @open_hours = query['open_hours']
    @menus = query['menus']
    @data = nil
    @venue_queries = { 'categories' => { 'str_id' => 'restaurants' } }
  end

  def build_venue_queries
    venue_queries['name'] = name if name
    build_menus_query
    venue_queries['open_hours'] = open_hours if open_hours
    venue_queries['categories']['str_id'] = categories if categories
    build_location_query
    unless venue_queries['location']
      venue_queries['location'] = {}
      venue_queries['location']['locality'] = IpApi.new.data['city']
    end
    venue_queries
  end

  def search_function
    default_fields = [ "name", "description", "website_url", "menus",
      "open_hours", "categories", "location", "contact", "delivery" ]
    post_url = "https://api.locu.com/v2/venue/search"
    message = {
      "api_key" => "#{ENV['LOCU_API_KEY']}",
      "fields" => default_fields,
      "venue_queries" => [ build_venue_queries ]
    }
    @data = HTTParty.post(post_url,
      body: message.to_json,
      headers: {'Content-Type' =>'application/json'} )
  end

  private

  def build_menus_query
    if menus
      venue_queries['menus'] = {}
      venue_queries['menus']['$present'] = true
    end
  end

  def build_location_query
    if location
      venue_queries['location'] = {}
      if location['locality']
        venue_queries['location']['locality'] = location['locality']
      elsif location['postal_code']
        venue_queries['location']['postal_code'] = location['postal_code']
      elsif location['lat_lng_radius']
        venue_queries['location']['geo'] = {}
        venue_queries['location']['geo']['$in_lat_lng_radius'] = location['llr']
      end
    end
  end

end
