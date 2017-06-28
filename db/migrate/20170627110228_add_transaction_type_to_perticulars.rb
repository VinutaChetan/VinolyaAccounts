class AddTransactionTypeToPerticulars < ActiveRecord::Migration
  def change
    add_column :perticulars, :transaction_type, :string
  end
end
