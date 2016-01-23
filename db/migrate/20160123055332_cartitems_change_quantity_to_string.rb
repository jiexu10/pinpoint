class CartitemsChangeQuantityToString < ActiveRecord::Migration
  def change
    remove_column :cartitems, :quantity, :integer, null: false

    add_column :cartitems, :quantity, :string, null: false
  end
end
