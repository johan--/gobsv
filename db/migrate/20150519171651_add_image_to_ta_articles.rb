class AddImageToTaArticles < ActiveRecord::Migration
  def change
    add_attachment :ta_articles, :image
  end
end
