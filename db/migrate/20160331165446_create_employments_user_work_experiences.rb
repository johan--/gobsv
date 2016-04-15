class CreateEmploymentsUserWorkExperiences < ActiveRecord::Migration
  def change
    create_table :employments_user_work_experiences do |t|
      t.references :user, index: true
      t.string :sector
      t.references :country
      t.string :institution_name
      t.string :charge
      t.text :description
      t.date :start_at
      t.date :end_at
      t.integer :active
      t.integer :user_created
      t.integer :user_edited
      t.timestamps
    end
  end
end
