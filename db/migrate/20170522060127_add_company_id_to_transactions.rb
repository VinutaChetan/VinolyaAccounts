class AddCompanyIdToTransactions < ActiveRecord::Migration
  def change
  	add_column :transactions,:company_id,:integer
  end
end
