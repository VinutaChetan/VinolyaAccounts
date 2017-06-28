class AddPerticularTypeToPerticulars < ActiveRecord::Migration
  def change
  	add_column :perticulars, :perticular_type, :string
  end
end
