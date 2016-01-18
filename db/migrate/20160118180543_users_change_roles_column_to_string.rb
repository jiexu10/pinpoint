class UsersChangeRolesColumnToString < ActiveRecord::Migration
  def change
    remove_column :users, :role_id, :integer
    add_column :users, :role, :string
  end
end
