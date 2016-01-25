class RestaurantsController < ApplicationController
  def show
    @restaurant = Restaurant.find(params[:id])
    orders = @restaurant.orders
    @pend_orders = orders.where(order_status: 'Pending').order(created_at: :asc)
    @comp_orders = orders.where(order_status: 'Completed').order(created_at: :desc)
  end
end
