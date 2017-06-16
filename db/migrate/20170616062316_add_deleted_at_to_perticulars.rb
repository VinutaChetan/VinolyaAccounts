class AddDeletedAtToPerticulars < ActiveRecord::Migration
  def change
    add_column :perticulars, :deleted_at, :datetime
    add_index :perticulars, :deleted_at
  end
end
