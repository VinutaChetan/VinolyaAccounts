class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.date :transaction_date
      t.integer :perticular_id
      t.string :transaction_type
      t.text :remark
      t.string :transaction_kind

      t.timestamps null: false
    end
  end
end
