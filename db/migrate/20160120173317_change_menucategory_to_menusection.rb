class ChangeMenucategoryToMenusection < ActiveRecord::Migration
  def change
    remove_reference :items, :menucategory

    add_reference :items, :menusection
  end
end
