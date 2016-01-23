class AddItemsTimestamps < ActiveRecord::Migration
  def change
    add_column :items, :created_at, :datetime, null: false
    add_column :items, :updated_at, :datetime, null: false
  end
end
