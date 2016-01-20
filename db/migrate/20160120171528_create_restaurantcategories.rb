class CreateRestaurantcategories < ActiveRecord::Migration
  def change
    create_table :restaurantcategories do |t|
      t.belongs_to :restaurantdetail, null: false
      t.belongs_to :category, null: false

      t.timestamps null: false
    end
  end
end
