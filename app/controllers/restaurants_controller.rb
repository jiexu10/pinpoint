class RestaurantsController < ApplicationController
  def show
    @restaurant = Restaurant.find(params[:id])
    if current_restaurant == @restaurant
      orders = @restaurant.orders
      pending = Status.find_by(name: 'Pending')
      confirmed = Status.find_by(name: 'Confirmed')
      delivery = Status.find_by(name: 'Delivery')
      complete = Status.find_by(name: 'Complete')
      @pending_orders = orders.where(status: pending).order(created_at: :asc)
      @confirmed_orders = orders.where(status: confirmed).order(created_at: :asc)
      @delivery_orders = orders.where(status: delivery).order(created_at: :asc)
      @complete_orders = orders.where(status: complete).order(created_at: :desc)
    else
      flash[:notice] = 'Action not permitted.'
      redirect_to root_path
    end
  end
end
