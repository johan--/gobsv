class CreateEmploymentsContracts < ActiveRecord::Migration
  def change
    create_table :employments_contracts do |t|
      t.references :plaza, index: true
      t.string :name
      t.string :last_name
      t.timestamps
    end
  end
end
