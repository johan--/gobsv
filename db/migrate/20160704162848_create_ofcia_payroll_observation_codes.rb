class CreateOfciaPayrollObservationCodes < ActiveRecord::Migration
  def change
    create_table :ofcia_payroll_observation_codes do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
