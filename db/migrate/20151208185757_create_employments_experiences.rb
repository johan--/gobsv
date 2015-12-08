class CreateEmploymentsExperiences < ActiveRecord::Migration
  def change
    create_table :employments_experiences do |t|
      t.references :plaza, index: true
      t.string :exp_code
      t.string :exp_name
      t.string :exp_description
      t.timestamps
    end
  end
end
