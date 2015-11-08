class CreateInvWarehouses < ActiveRecord::Migration
  def change
    create_table :inv_warehouses do |t|
      t.string :name, null: false, default: ''

      t.timestamps
    end
  end
end
