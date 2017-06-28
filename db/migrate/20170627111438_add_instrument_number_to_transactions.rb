class AddInstrumentNumberToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :instrument_number, :string
  end
end
