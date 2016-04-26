class CreateEmploymentsUserPostulations < ActiveRecord::Migration
  def change
    create_table :employments_user_postulations do |t|
      t.references :user
      t.references :plaza
      t.string :code
      t.string :response_code
      t.timestamps null: false
    end
  end
end
