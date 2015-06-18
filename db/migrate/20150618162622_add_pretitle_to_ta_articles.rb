class AddPretitleToTaArticles < ActiveRecord::Migration
  def change
    add_column :ta_articles, :pretitle, :string, null: false, default: ''
  end
end
