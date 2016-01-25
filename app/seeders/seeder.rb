class Seeder
  WORKING_RESTAURANTS = [
    "Betty's Wok & Noodle Diner",
    "Siam Bistro",
    "Papagayo",
    "Morse Fish Company",
    "The Wholy Grain"
  ].freeze

  STATUSES = [
    ['Pending', 1],
    ['Confirmed', 2],
    ['Delivery', 3],
    ['Complete', 4]
  ].freeze

  def self.seed_restaurants
    WORKING_RESTAURANTS.each_with_index do |restaurant_name, index|
      attributes = {
        first_name: 'Fakefirst',
        last_name: 'Fakelast',
        email: "fake#{index}@fake.com",
        company_name: restaurant_name,
        password: 'password'
      }
      restaurant = Restaurant.create(attributes)
      MakeRestaurantDetail.new(restaurant, 'name' => restaurant.company_name)
    end
  end

  def self.seed_statuses
    STATUSES.each do |status_info|
      Status.find_or_create_by(name: status_info.first) do |status|
        status.sequence = status_info.last
      end
    end
  end
end
