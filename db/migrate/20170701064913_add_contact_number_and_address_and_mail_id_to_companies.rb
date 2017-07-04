class AddContactNumberAndAddressAndMailIdToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :contact_number, :string
    add_column :companies, :address, :text
    add_column :companies, :mail_id, :string
  end
end
