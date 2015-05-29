class AddCategoryIdToTaArticles < ActiveRecord::Migration
  def change
    add_column :ta_articles, :category_id, :integer, index: true
  end
end
