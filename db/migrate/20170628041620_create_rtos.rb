class CreateRtos < ActiveRecord::Migration
  def change
    create_table :rtos do |t|

      t.timestamps null: false
    end
  end
end
