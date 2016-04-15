class CreateEmploymentsUserDisabilities < ActiveRecord::Migration
  def change
    create_table :employments_user_disabilities do |t|
      t.references :user, index: true
      t.references :disability_type
      t.references :disability_certification
      t.integer :user_created
      t.integer :user_edited
      t.timestamps
    end
  end
end
