require 'net/http'
require 'pry'
require 'openssl'
require 'json'

class LocuData
  attr_reader :data
  attr_accessor :location

  def initialize
    # @location = location
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
      "fields": [ "name" ],
      "venue_queries": [
        {
          "name": "bistro central parc"
        }
      ]
    })
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new("/v2/venue/search", initheader = {'Content-Type' =>'application/json'})
    request.body = message

    response = http.request(request)
    binding.pry
    @data = JSON.parse(response.body)
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
