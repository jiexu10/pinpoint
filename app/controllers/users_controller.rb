class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    if @user.role == 'user'
      orders = @user.orders.order(created_at: :desc)
    elsif @user.role == 'driver'
      orders = Order.where(driver: @user).order(created_at: :desc)
    end

    @comp_orders = orders.select { |order| order.status.name == 'Complete' }
    @pending_orders = orders - @comp_orders
  end
end
