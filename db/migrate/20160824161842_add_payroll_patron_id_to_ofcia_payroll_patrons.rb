class AddPayrollPatronIdToOfciaPayrollPatrons < ActiveRecord::Migration
  def change
    add_column :ofcia_payroll_patrons, :payroll_patron_id, :integer
    add_index :ofcia_payroll_patrons, :payroll_patron_id
  end
end
