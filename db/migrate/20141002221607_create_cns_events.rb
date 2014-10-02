class CreateCnsEvents < ActiveRecord::Migration
  def change
    create_table :cns_events do |t|
      t.string :name, null: false
      t.text :description
      t.date :event_date, null: false

      t.timestamps
    end
  end
end
