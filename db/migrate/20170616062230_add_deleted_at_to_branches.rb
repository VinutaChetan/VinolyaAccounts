class AddDeletedAtToBranches < ActiveRecord::Migration
  def change
    add_column :branches, :deleted_at, :datetime
    add_index :branches, :deleted_at
  end
end
