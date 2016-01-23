class OrdersCapitalizeDefaultStatus < ActiveRecord::Migration
  def change
    remove_column :orders, :order_status, :string, default: 'pending', null: false

    add_column :orders, :order_status, :string, default: 'Pending', null: false
  end
end
