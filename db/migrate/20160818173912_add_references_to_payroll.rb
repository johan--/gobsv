class AddReferencesToPayroll < ActiveRecord::Migration
  def change
    add_foreign_key :ofcia_payrolls, :ofcia_payroll_patrons, column: :payroll_patron_id
    add_foreign_key :ofcia_payroll_patrons, :ofcia_payroll_economic_activities, column: :payroll_economic_activity_id
  end
end
