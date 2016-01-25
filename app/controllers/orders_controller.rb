class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @cart = @order.cart if @order.cart.status == 'ordered'
  end

  def create
    cart = Cart.find(order_params[:cart_id])
    restaurant = Restaurant.find(order_params[:restaurant_id])
    order = Order.new(cart: cart, restaurant: restaurant, user: current_user)
    if order.save && cart.update_attributes(status: 'ordered')
      flash[:notice] = 'Order Placed!'
      redirect_to order_path(order)
    else
      flash[:error] = 'Error in order'
      redirect_to restaurant.restaurantdetail
    end
  end

  private

  def order_params
    params.require(:order).permit(:cart_id, :restaurant_id)
  end
end
