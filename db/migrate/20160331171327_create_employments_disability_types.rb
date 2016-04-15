class CreateEmploymentsDisabilityTypes < ActiveRecord::Migration
  def change
    create_table :employments_disability_types do |t|
      t.string :name
      t.timestamps
    end
  end
end
