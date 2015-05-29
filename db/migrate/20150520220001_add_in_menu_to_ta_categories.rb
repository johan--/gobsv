class AddInMenuToTaCategories < ActiveRecord::Migration
  def change
    add_column :ta_categories, :inmenu, :boolean, null: false, default: false
  end
end
