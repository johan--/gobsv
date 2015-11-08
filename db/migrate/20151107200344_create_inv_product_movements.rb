class CreateInvProductMovements < ActiveRecord::Migration
  def change
    create_table :inv_product_movements do |t|
      t.integer :kind, null: false, default: 0
      t.integer :cause, null: false, default: 0
      t.text :comments
      t.integer :product_id, null: false
      t.integer :warehouse_id, null: false
      t.integer :quantity, null: false, default: 0
      t.integer :admin_id, null: false

      t.timestamps
    end
  end
end
