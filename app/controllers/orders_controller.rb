class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @cart = @order.cart if @order.cart.status == 'ordered'
  end

  def create
    cart = Cart.find(order_params[:cart_id])
    restaurant = Restaurant.find(order_params[:restaurant_id])
    pending_status = Status.find_by(name: 'Pending')
    order = Order.new(cart: cart, restaurant: restaurant, status: pending_status, user: current_user)
    if order.save && cart.update_attributes(status: 'ordered')
      flash[:notice] = 'Order Placed!'
      redirect_to order_path(order)
    end
  end

  def update
    binding.pry
  end
  private

  def order_params
    params.require(:order).permit(:cart_id, :restaurant_id)
  end
end
