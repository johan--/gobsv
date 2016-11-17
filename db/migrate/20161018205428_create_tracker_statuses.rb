class CreateTrackerStatuses < ActiveRecord::Migration
  def change
    create_table :tracker_statuses do |t|
      t.string     :name,   null: false
      t.references :status, index: true
      t.timestamps null: false
    end
  end
end
