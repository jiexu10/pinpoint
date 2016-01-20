class ChangeItemsRestaurantToRestaurantdetails < ActiveRecord::Migration
  def change
    remove_reference :items, :restaurant, null: false

    add_reference :items, :restaurantdetail, null: false
  end
end
