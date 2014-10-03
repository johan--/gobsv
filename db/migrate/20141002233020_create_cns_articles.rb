class CreateCnsArticles < ActiveRecord::Migration
  def change
    create_table :cns_articles do |t|
      t.string :name, null: false
      t.text :description
      t.date :article_date, null: false

      t.timestamps
    end
  end
end
