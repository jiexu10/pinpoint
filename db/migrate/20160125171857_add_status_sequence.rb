class AddStatusSequence < ActiveRecord::Migration
  def change
    add_column :statuses, :sequence, :integer, null: false
  end
end
