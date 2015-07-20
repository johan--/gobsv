class AddVideoUrlToTaArticles < ActiveRecord::Migration
  def change
    add_column :ta_articles, :video_url, :string, null: false, default: ''
  end
end
