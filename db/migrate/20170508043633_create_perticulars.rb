class CreatePerticulars < ActiveRecord::Migration
  def change
    create_table :perticulars do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
