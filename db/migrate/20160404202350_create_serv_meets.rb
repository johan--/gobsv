class CreateServMeets < ActiveRecord::Migration
  def change
    create_table :serv_meets do |t|
      t.integer :room_id
      t.integer :admin_id
      t.integer :audience_type, null: false, dafault: 0
      t.integer :assistants_number, null: false, dafault: 0
      t.boolean :require_assistance, null: false, default: false
      t.text :observations
      t.string :title, null: false, default: ''
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
