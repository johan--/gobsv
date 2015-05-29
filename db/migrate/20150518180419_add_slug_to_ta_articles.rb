class AddSlugToTaArticles < ActiveRecord::Migration
  def change
    add_column :ta_articles, :slug, :string, index: true, uniq: true
  end
end
