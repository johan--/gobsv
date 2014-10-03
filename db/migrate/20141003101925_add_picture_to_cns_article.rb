class AddPictureToCnsArticle < ActiveRecord::Migration

  def up
    add_attachment :cns_articles, :picture
  end

  def down
    add_attachment :cns_articles, :picture
  end
end
