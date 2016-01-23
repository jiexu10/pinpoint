class AddQuantityToCartitems < ActiveRecord::Migration
  def change
    add_column :cartitems, :quantity, :integer, null: false
  end
end
