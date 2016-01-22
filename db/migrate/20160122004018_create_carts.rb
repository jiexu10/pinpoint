class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.belongs_to :user, null: false
      t.belongs_to :restaurant, null: false
      t.belongs_to :order
      t.string :status, default: 'pending', null: false

      t.timestamps null: false
    end
  end
end
