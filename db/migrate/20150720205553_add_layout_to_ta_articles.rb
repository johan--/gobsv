class AddLayoutToTaArticles < ActiveRecord::Migration
  def change
    add_column :ta_articles, :layout, :integer, null: false, default: 0
  end
end
