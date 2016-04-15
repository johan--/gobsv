class CreateEmploymentsUserTrainings < ActiveRecord::Migration
  def change
    create_table :employments_user_trainings do |t|
      t.references :user, index: true
      t.string :institution_name
      t.string :name
      t.text :description
      t.string :place
      t.string :duration
      t.integer :year
      t.integer :user_created
      t.integer :user_edited
      t.timestamps
    end
  end
end
