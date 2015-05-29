class CreateTaArticles < ActiveRecord::Migration
  def change
    create_table :ta_articles do |t|
      t.string :title
      t.text :summary
      t.text :content

      t.timestamps
    end
  end
end
