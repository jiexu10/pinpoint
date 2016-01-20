class ChangeRestaurantdetailsAddressTwoAllowBlank < ActiveRecord::Migration
  def change
    remove_column :restaurantdetails, :address_two, :string, null: false

    add_column :restaurantdetails, :address_two, :string
  end
end
