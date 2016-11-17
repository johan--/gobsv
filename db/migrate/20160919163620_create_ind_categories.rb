class CreateIndCategories < ActiveRecord::Migration
  def change
    create_table :ind_categories do |t|
      t.string :name
      t.string :color
      t.string :description
      t.timestamps null: false
    end
  end
end
