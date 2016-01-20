class CreateMenusections < ActiveRecord::Migration
  def change
    create_table :menusections do |t|
      t.string :name, null: false
      t.belongs_to :restaurantdetail, null: false

      t.timestamps null: false
    end
  end
end
