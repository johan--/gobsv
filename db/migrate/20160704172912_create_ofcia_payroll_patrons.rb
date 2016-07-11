class CreateOfciaPayrollPatrons < ActiveRecord::Migration
  def change
    create_table :ofcia_payroll_patrons do |t|
      t.string :employer_id
      t.string :name
      t.string :nit
      t.integer :sector_id
      t.integer :economic_activity_id

      t.timestamps null: false
    end
    add_index :ofcia_payroll_patrons, :employer_id
  end
end
