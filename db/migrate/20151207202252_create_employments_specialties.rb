class CreateEmploymentsSpecialties < ActiveRecord::Migration
  def change
    create_table :employments_specialties do |t|
      t.references :plaza, index: true
      t.string :esp_code
      t.string :esp_name
      t.string :req_code
      t.string :req_name
      t.timestamps
    end
  end
end
