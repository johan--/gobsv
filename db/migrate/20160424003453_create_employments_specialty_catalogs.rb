class CreateEmploymentsSpecialtyCatalogs < ActiveRecord::Migration
  def change
    create_table :employments_specialties do |t|
      t.string :esp_code
      t.string :esp_name
      t.string :gra_code
      t.string :gra_name
      t.timestamps null: false
    end
  end
end
