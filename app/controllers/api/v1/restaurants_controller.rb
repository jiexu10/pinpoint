class Api::V1::RestaurantsController < Api::V1::BaseController
  def show
    restaurant = Restaurant.find(params[:id])
    coord = restaurant.restaurantdetail.coordinates
    parse_coord = coord.match(/\[(\S+), (\S+)\]/)
    latitude = parse_coord[2].to_f
    longitude = parse_coord[1].to_f
    render json: { lat: latitude, lng: longitude }
  end
end
