class AddIconToCnsCategories < ActiveRecord::Migration
  def change
  	add_attachment :cns_categories, :icon
  end
end
