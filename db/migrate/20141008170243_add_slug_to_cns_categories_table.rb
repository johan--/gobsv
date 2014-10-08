class AddSlugToCnsCategoriesTable < ActiveRecord::Migration
  def change
    add_column :cns_categories, :slug, :string
    add_index :cns_categories, :slug
  end
end
