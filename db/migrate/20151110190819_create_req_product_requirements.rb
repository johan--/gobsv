class CreateReqProductRequirements < ActiveRecord::Migration
  def change
    create_table :req_product_requirements do |t|
      t.integer :requirement_id, null: false
      t.integer :product_id, null: false
      t.integer :quantity, null: false, default: 0

      t.timestamps
    end
  end
end
