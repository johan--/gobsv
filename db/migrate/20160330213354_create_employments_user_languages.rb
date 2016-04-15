class CreateEmploymentsUserLanguages < ActiveRecord::Migration
  def change
    create_table :employments_user_languages do |t|
      t.references :user, index: true
      t.string :name
      t.string :read
      t.integer :write
      t.integer :speak
      t.integer :user_created
      t.integer :user_edited
      t.timestamps
    end
  end
end
