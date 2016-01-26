class AddRolesColumnToUsersLatitudeLongitude < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: 'user', null: false
    add_column :users, :latitude, :decimal, precision: 18, scale: 15
    add_column :users, :longitude, :decimal, precision: 18, scale: 15
  end
end
