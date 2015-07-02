class AddFrontToTaArticles < ActiveRecord::Migration
  def change
    add_column :ta_articles, :front, :boolean, dafault: false
  end
end
