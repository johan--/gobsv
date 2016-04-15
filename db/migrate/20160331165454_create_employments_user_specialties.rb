class CreateEmploymentsUserSpecialties < ActiveRecord::Migration
  def change
    create_table :employments_user_specialties do |t|
      t.references :user, index: true
      t.references :country
      t.string :name
      t.string :esp_code
      t.string :esp_name
      t.string :gra_code
      t.string :institution_name
      t.attachment :certificate
      t.date :start_at
      t.date :end_at
      t.integer :user_created
      t.integer :user_edited
      t.timestamps
    end
  end
end
