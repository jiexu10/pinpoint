require 'pry'
require 'net/http'
require 'json'

class IpApi
  attr_reader :data

  def initialize(default = '')
    uri_string = "http://ip-api.com/json/#{default}?fields=24816"
    uri = URI(uri_string)
    response = Net::HTTP.get(uri)

    @data = JSON.parse(response)
  end
end
