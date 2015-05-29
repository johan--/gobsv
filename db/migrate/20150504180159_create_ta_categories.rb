class CreateTaCategories < ActiveRecord::Migration
  def change
    create_table :ta_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
