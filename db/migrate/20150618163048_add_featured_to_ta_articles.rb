class AddFeaturedToTaArticles < ActiveRecord::Migration
  def change
    add_column :ta_articles, :featured, :boolean, null: false, default: false
  end
end
