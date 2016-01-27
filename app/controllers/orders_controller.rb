class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    if current_user == @order.user
      @cart = @order.cart if @order.cart.status == 'ordered'
    else
      flash[:notice] = 'Action not permitted.'
      redirect_to root_path
    end
  end

  def create
    cart = Cart.find(order_params[:cart_id])
    restaurant = Restaurant.find(order_params[:restaurant_id])
    pending = Status.find_by(name: 'Pending')
    driver = User.find_by(role: 'driver')
    order = Order.new(cart: cart, driver: driver, restaurant: restaurant,
                        status: pending, user: current_user)
    if order.save && cart.update_attributes(status: 'ordered')
      flash[:notice] = 'Order Placed!'
      redirect_to order_path(order)
    end
  end

  def update
    order = Order.find(order_params[:id]) if order_params[:id]
    if current_restaurant == order.restaurant
      new_status = Status.find_by(sequence: order_params[:new_sequence])
      if order.update_attributes(status: new_status)
        flash[:notice] = 'Order Updated!'
        redirect_to restaurant_path(current_restaurant)
      end
    else
      flash[:notice] = 'Action not permitted.'
      redirect_to root_path
    end
  end
  private

  def order_params
    params.require(:order).permit(:cart_id, :restaurant_id, :id, :new_sequence)
  end
end
