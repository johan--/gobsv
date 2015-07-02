class AddIndexToSlugOnTaCategories < ActiveRecord::Migration
  def change
    change_column :ta_categories, :slug, :string, index: true, uniq: true
  end
end
