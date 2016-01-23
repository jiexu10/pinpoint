class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end
  def show
    @restaurant = Restaurant.find(params[:id])
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
