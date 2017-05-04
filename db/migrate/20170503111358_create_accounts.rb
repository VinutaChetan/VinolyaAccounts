class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :acc_no
      t.float :opening_balance
      t.integer :bank_id
      t.integer :branch_id
      t.string :acc_type
      t.float :current_balance

      t.timestamps null: false
    end
  end
end
