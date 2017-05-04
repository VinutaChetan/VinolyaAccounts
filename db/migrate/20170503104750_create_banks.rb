class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :name
      t.text :address
      t.string :manager
      t.string :contact_details
      t.integer :branch_id
      t.integer :company_id

      t.timestamps null: false
    end
  end
end
