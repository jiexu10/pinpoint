class CategoriesAddStrIdColumn < ActiveRecord::Migration
  def change
    add_column :categories, :str_id, :string, null: false
  end
end
