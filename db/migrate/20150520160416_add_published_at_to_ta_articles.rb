class AddPublishedAtToTaArticles < ActiveRecord::Migration
  def change
    add_column :ta_articles, :published_at, :datetime
  end
end
