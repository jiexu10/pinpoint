require_relative '../../spec/support/restaurant_helper'
require 'factory_girl_rails'

class Seeder
  WORKING_RESTAURANTS = [
    "Boston Beer Garden",
    "Betty's Wok & Noodle Diner",
    "Siam Bistro",
    "Papagayo",
    "Morse Fish Company",
    "The Wholy Grain"
  ].freeze

  def self.seed_restaurants
    WORKING_RESTAURANTS.each do |restaurant|
      create_restaurant(restaurant)
    end
  end
end
