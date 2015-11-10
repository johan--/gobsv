class CreateReqRequirements < ActiveRecord::Migration
  def change
    create_table :req_requirements do |t|
      t.string :code, null: false, default: ''
      t.integer :status, null: false, default: 0
      t.integer :admin_id, null: false

      t.timestamps
    end
  end
end
