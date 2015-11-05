class CreateComplaintsExpedientManagementEvents < ActiveRecord::Migration
  def change
    create_table :complaints_expedient_management_events do |t|
      t.string :status, default: 'process'
      t.references :expedient_management
      t.references :admin, index: true
      t.datetime :start_at
      t.text :justification
      t.timestamps
    end
    add_index :complaints_expedient_management_events, :expedient_management_id, name: 'expedient_management_id_index'
  end
end
