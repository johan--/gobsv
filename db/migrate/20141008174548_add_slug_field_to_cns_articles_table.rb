class AddSlugFieldToCnsArticlesTable < ActiveRecord::Migration
  def change
    add_column :cns_articles, :slug, :string
    add_index :cns_articles, :slug
  end
end
