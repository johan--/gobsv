class AddImageSizeToTaArticles < ActiveRecord::Migration
  def change
    add_column :ta_articles, :image_width, :integer, null: false, default: 0
    add_column :ta_articles, :image_height, :integer, null: false, default: 0
  end
end
