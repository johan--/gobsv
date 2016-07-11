class CreateOfciaPayrollSectors < ActiveRecord::Migration
  def change
    create_table :ofcia_payroll_sectors do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
