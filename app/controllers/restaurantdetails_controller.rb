class RestaurantdetailsController < ApplicationController
  def index
    @restaurantdetails = Restaurantdetail.all
  end

  def show
    @restaurantdetail = Restaurantdetail.find(params[:id])
    @restaurant = @restaurantdetail.restaurant
    if user_signed_in?
      @cart = Cart.find_or_create_by(user: current_user, restaurant: @restaurant, status: "pending")
      @cartitems = []
      @restaurant.items.each do |item|
        @cartitems << Cartitem.find_or_initialize_by(item: item, cart: @cart)
      end
      @order = Order.new(restaurant: @restaurant, cart: @cart)
    end
  end
end
