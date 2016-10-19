class CreateTrackerArticles < ActiveRecord::Migration
  def change
    create_table :tracker_articles do |t|
      t.string     :name,         null: false
      t.text       :description,  null: false, default: ""
      t.datetime   :publish_date, null: false
      t.references :author,       index: true
      t.references :status,       index: true
      t.timestamps                null: false
    end
  end
end
