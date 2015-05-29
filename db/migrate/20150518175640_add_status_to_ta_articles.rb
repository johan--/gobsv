class AddStatusToTaArticles < ActiveRecord::Migration
  def change
    add_column :ta_articles, :status, :string
  end
end
