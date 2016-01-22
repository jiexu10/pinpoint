class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :user, null: false
      t.belongs_to :restaurant, null: false
      t.string :order_status, default: "pending", null: false

      t.timestamps null: false
    end
  end
end
