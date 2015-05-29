class AddUserRefToTaArticles < ActiveRecord::Migration
  def change
    add_reference :ta_articles, :user, index: true
  end
end
