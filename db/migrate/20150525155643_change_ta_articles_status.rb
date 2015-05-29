class ChangeTaArticlesStatus < ActiveRecord::Migration
  def up
    remove_column :ta_articles, :status
    add_column :ta_articles, :status, :integer, null: false, default: 0
    Ta::Article.update_all(status: Ta::Article.statuses[:publish])
  end

  def down
    remove_column :ta_articles, :status
    add_column :ta_articles, :status, :string
    Ta::Article.update_all(status: 'publish')
  end
end
