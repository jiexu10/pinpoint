require 'net/http'
require 'pry'
require 'openssl'
require 'json'
require 'httparty'

class LocuData
  include HTTParty
  attr_reader :data, :name, :location, :categories

  base_uri "https://api.locu.com"

  def initialize(query = {})
    @name = query['name']
    @location = query['location']
    @categories = query['categories']
    @open_hours = query['open_hours']
    @menus = query['menus']
    @data = nil
  end

  def get_posts
    uri_string = "https://api.locu.com"
    uri = URI.parse(uri_string)
    message = '{
      "api_key": "0a617b50e355f12544adc19e76d4714d0d8a6a46",
      "fields": [ "name" ],
      "venue_queries": [
        {
          "name": "bistro central parc"
        }
      ]
    }'
    # binding.pry
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new("/v2/venue/search", initheader = {'Content-Type' =>'application/json'})
    # request.add_field('Content-Type', 'application/json')
    request.body = message
    # response = http.start { |http| http.request(request) }

    # uri = URI.parse('https://api.locu.com/v2/venue/search')
    # response = Net::HTTP.post_form(uri, message)
    # http = Net::HTTP.new(uri.host, uri.port)
    # request = Net::HTTP::Post.new(uri.request_uri)
    # request.set_form_data(message)

    response = http.request(request)
    binding.pry
    @data = JSON.parse(response)
    binding.pry
  end

  def get_stuff
    uri_string = "https://api.locu.com"
    uri = URI.parse(uri_string)
    message = %Q({
      "api_key": "#{ENV['LOCU_API_KEY']}",
      "fields": [ "name", "categories", "location", "menus" ],
      "venue_queries": [
        {
          "location": {
              "locality": "Boston"
            },
          "categories": {
              "str_id": "restaurants"
          }
        }
      ]
    })
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new("/v2/venue/search", initheader = {'Content-Type' =>'application/json'})
    request.body = message

    response = http.request(request)
    @data = JSON.parse(response.body)
    binding.pry
  end

  def build_venue_queries
    venue_queries = {}
    venue_queries['name'] = @name if @name
    venue_queries['categories']['str_id'] = @categories if @categories
    venue_queries['menus']['$present'] = true if @menu
    venue_queries['open_hours'] = @open_hours if @open_hours
    venue_queries['location']['locality'] = @location['locality'] if @location['locality']
    venue_queries['location']['postal_code'] = @location['postal_code'] if @location['postal_code']
    venue_queries['location']['geo']['$in_lat_lng_radius'] = @location['lat_lng_radius'] if @location['lat_lng_radius']
    if venue_queries.empty?
      venue_queries['location']['locality'] = 'Boston'
    end
    venue_queries
  end

  def search_function
    default_fields = [ "name", "description", "website_url", "menus", "open_hours", "categories", "location", "contact", "delivery" ]
    post_url = "https://api.locu.com/v2/venue/search"
    message = {
      "api_key" => "#{ENV['LOCU_API_KEY']}",
      "fields" => default_fields,
      "venue_queries" => [ build_venue_queries ]
    }
    @data = HTTParty.post(post_url,
      body: message.to_json,
      headers: {'Content-Type' =>'application/json'} )
    binding.pry
  end
  # def parse
  #   unless @data
  #     get_posts
  #   end
  #   output = []
  #   @data['data']['children'].each do |post|
  #     unless post['data']['stickied']
  #       title = post['data']["title"]
  #       url = "https://www.reddit.com" + post['data']['permalink']
  #       descrip = post['data']['selftext']
  #       output << { 'Title' => title, 'URL' => url, 'Description' => descrip }
  #     end
  #   end
  #   output
  # end
end

binding.pry
