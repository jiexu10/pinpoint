class OrdersCreateCart < ActiveRecord::Migration
  def change
    add_reference :orders, :cart, null: false

    add_index :orders, :cart_id, unique: true
  end
end
