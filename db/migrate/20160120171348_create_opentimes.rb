class CreateOpentimes < ActiveRecord::Migration
  def change
    create_table :opentimes do |t|
      t.belongs_to :restaurantdetail, null: false
      t.string :day, null: false
      t.string :hours, null: false

      t.timestamps null: false
    end
  end
end
