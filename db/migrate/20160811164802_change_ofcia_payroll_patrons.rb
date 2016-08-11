class ChangeOfciaPayrollPatrons < ActiveRecord::Migration
  def change
    remove_column :ofcia_payroll_patrons, :employer_id, :string
    remove_column :ofcia_payroll_patrons, :sector_id, :integer
    remove_column :ofcia_payroll_patrons, :economic_activity_id, :integer
    add_column :ofcia_payroll_patrons, :payroll_economic_activity_id, :integer
  end
end
