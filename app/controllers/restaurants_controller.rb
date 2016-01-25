class RestaurantsController < ApplicationController
  def show
    @restaurant = Restaurant.find(params[:id])
    if current_restaurant == @restaurant
      orders = @restaurant.orders
      @pending_status = Status.find_by(name: 'Pending')
      @confirm_status = Status.find_by(name: 'Confirmed')
      @delivery_status = Status.find_by(name: 'Delivery')
      @comp_status = Status.find_by(name: 'Complete')
      @pend_orders = orders.where(status: @pending_status).order(created_at: :asc)
      @confirm_orders = orders.where(status: @confirm_status).order(created_at: :asc)
      @delivery_orders = orders.where(status: @delivery_status).order(created_at: :asc)
      @comp_orders = orders.where(status: @comp_status).order(created_at: :desc)
    else
      flash[:notice] = 'Action not permitted.'
      redirect_to root_path
    end
  end
end
