class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :description
      t.string :price, null: false
      t.belongs_to :menucategory
      t.belongs_to :restaurant, null: false
    end
  end
end
