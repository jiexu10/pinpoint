class AddDriverToOrders < ActiveRecord::Migration
  def change
    add_belongs_to :orders, :driver
  end
end
