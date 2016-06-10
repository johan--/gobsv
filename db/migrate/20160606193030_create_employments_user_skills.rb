class CreateEmploymentsUserSkills < ActiveRecord::Migration
  def change
    create_table :employments_user_skills do |t|
      t.references :user, index: true
      t.text :name
      t.timestamps null: false
    end
  end
end
