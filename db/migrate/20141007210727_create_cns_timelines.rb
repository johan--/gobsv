class CreateCnsTimelines < ActiveRecord::Migration
  def change
    create_table :cns_timelines do |t|
      t.string :name
      t.string :url
      t.text :description
      t.date :timeline_date
      t.timestamps
    end
  end
end
