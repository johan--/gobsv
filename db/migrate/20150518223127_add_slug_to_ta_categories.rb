class AddSlugToTaCategories < ActiveRecord::Migration
  def change
    add_column :ta_categories, :slug, :string
  end
end
