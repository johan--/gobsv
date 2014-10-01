class CreateCnsCategories < ActiveRecord::Migration
  def change
    create_table :cns_categories do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end
