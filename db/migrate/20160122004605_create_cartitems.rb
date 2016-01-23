class CreateCartitems < ActiveRecord::Migration
  def change
    create_table :cartitems do |t|
      t.belongs_to :cart, null: false
      t.belongs_to :item, null: false

      t.timestamps null: false
    end
  end
end
