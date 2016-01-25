class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    orders = @user.orders.order(created_at: :desc)

    @comp_orders = orders.select { |order| order.order_status == 'Completed' }
    @pending_orders = orders - @comp_orders
  end
end
