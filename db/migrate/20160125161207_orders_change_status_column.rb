class OrdersChangeStatusColumn < ActiveRecord::Migration
  def change
    remove_column :orders, :order_status, :string, default: 'Pending', null: false

    add_reference :orders, :status, null: false
  end
end
