class ChangeTaArticlesUserId < ActiveRecord::Migration
  def change
    rename_column :ta_articles, :user_id, :author_id
  end
end
