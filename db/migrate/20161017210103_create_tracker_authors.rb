class CreateTrackerAuthors < ActiveRecord::Migration
  def change
    create_table :tracker_authors do |t|
      t.string :name, null: false, default: ""
      t.string :email, null: false, default: ""
      t.references :user, index: true
      t.timestamps null: false
    end
  end
end
