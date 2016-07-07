class CreateOfciaPayrollEconomicActivityGroups < ActiveRecord::Migration
  def change
    create_table :ofcia_payroll_economic_activity_groups do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
