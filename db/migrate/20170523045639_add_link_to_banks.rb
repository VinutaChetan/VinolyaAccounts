class AddLinkToBanks < ActiveRecord::Migration
  def change
  	add_column :banks,:link,:text
  end
end
