class AddBalanceToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :balance, :float
  end
end
