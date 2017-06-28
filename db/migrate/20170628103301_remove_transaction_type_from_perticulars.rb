class RemoveTransactionTypeFromPerticulars < ActiveRecord::Migration
  def change
  	remove_column :perticulars,:transaction_type
  end
end
