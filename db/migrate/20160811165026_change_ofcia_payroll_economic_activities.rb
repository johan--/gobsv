class ChangeOfciaPayrollEconomicActivities < ActiveRecord::Migration
  def change
    remove_column :ofcia_payroll_economic_activities, :economic_activity_group, :integer
    add_column :ofcia_payroll_economic_activities, :sector, :integer, default: 0
  end
end
