class CreateEmploymentsUserReferences < ActiveRecord::Migration
  def change
    create_table :employments_user_references do |t|
      t.references :user, index: true
      t.string :name
      t.string :charge
      t.string :address
      t.string :phone
      t.integer :type
      t.integer :user_created
      t.integer :user_edited
      t.timestamps
    end
  end
end
