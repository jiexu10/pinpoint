class OpentimesRemoveHoursAddOpenClose < ActiveRecord::Migration
  def change
    remove_column :opentimes, :hours, :string

    add_column :opentimes, :open_hour, :string
    add_column :opentimes, :close_hour, :string
  end
end
