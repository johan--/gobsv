class CreateOfciaPayrollEmploymentIndicators < ActiveRecord::Migration
  def change
    create_table :ofcia_payroll_employment_indicators do |t|
      t.integer :year
      t.integer :occupied, defaul: 0
      t.integer :unoccupied, defaul: 0
      t.integer :inactive, defaul: 0
      t.integer :pea, defaul: 0
      t.integer :pet, defaul: 0
      t.timestamps null: false
    end
  end
end
