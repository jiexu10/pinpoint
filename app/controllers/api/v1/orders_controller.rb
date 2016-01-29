class Api::V1::OrdersController < Api::V1::BaseController
  def show
    order = Order.find(order_params[:id])
    if order_params[:request] == 'restaurant'
      restaurant = order.restaurant
      coord = restaurant.restaurantdetail.coordinates
      parse_coord = coord.match(/\[(\S+), (\S+)\]/)
      latitude = parse_coord[2].to_f
      longitude = parse_coord[1].to_f
      render json: { lat: latitude, lng: longitude }
    elsif order_params[:request] == 'driver'
      driver = order.driver
      latitude = driver.latitude.to_f
      longitude = driver.longitude.to_f
      render json: { lat: latitude, lng: longitude }
    elsif order_params[:request] == 'user'
      render json: { status_name: order.status.name }
    end
  end

  private

  def order_params
    params.permit(:request, :id)
  end
end
