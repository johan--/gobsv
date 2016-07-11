class CreateOfciaPayrollEconomicActivities < ActiveRecord::Migration
  def change
    create_table :ofcia_payroll_economic_activities do |t|
      t.string :name
      t.integer :economic_activity_group

      t.timestamps null: false
    end
  end
end
