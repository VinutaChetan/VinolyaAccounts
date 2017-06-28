class AddInstrumentDateToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :instrument_date, :date
  end
end
