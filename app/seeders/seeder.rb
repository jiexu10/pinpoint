class Seeder
  WORKING_RESTAURANTS = [
    "Betty's Wok & Noodle Diner",
    "Morse Fish Company",
    "Papagayo",
    "Siam Bistro",
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
        first_name: 'Restaurant',
        last_name: 'Example',
        email: "restaurant#{index + 1}@example.com",
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

  def self.seed_user
    user = User.new
    user.first_name = 'Test'
    user.last_name = 'User'
    user.email = 'user@example.com'
    user.password = 'password'
    user.password_confirmation = 'password'
    user.save
  end

  def self.seed_driver
    driver = User.new
    driver.first_name = 'Test'
    driver.last_name = 'Driver'
    driver.email = 'driver@example.com'
    driver.password = 'password'
    driver.password_confirmation = 'password'
    driver.role = 'driver'
    driver.save
  end
end
