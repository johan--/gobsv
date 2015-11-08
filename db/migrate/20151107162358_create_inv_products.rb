class CreateInvProducts < ActiveRecord::Migration
  def change
    create_table :inv_products do |t|
      t.integer :unit_id, null: false
      t.string  :code, null: false, default: ''
      t.string  :name, null: false, default: ''

      t.timestamps
    end
  end
end
