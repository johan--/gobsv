class AddWarehouseFromToInvProductMovements < ActiveRecord::Migration
  def change
    add_column :inv_product_movements, :warehouse_from, :integer, null: true
  end
end
