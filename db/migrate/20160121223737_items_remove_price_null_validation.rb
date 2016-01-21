class ItemsRemovePriceNullValidation < ActiveRecord::Migration
  def change
    remove_column :items, :price, :string, null: false

    add_column :items, :price, :string
  end
end
