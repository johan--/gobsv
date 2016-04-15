class CreateEmploymentsDisabilityCertifications < ActiveRecord::Migration
  def change
    create_table :employments_disability_certifications do |t|
      t.string :name
      t.timestamps
    end
  end
end
