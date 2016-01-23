class CartsRemoveOrder < ActiveRecord::Migration
  def change
    remove_reference :carts, :order
  end
end
