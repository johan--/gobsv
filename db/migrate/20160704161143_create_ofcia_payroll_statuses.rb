class CreateOfciaPayrollStatuses < ActiveRecord::Migration
  def change
    create_table :ofcia_payroll_statuses do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
