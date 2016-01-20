class CreateRestaurantdetails < ActiveRecord::Migration
  def change
    create_table :restaurantdetails do |t|
      t.belongs_to :restaurant, null: false
      t.string :name, null: false
      t.string :description
      t.string :locuid, null: false
      t.string :phone, null: false
      t.string :website_url
      t.string :address_one, null: false
      t.string :address_two, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip_code, null: false
      t.string :coordinates
      t.string :delivery

      t.timestamps null: false
    end
  end
end
