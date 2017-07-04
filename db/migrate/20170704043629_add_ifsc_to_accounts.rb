class AddIfscToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :IFSC, :string
  end
end
