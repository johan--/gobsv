class CreateOfciaPayrollTypes < ActiveRecord::Migration
  def change
    create_table :ofcia_payroll_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
