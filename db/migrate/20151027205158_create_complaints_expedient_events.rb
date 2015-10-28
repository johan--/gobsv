class CreateComplaintsExpedientEvents < ActiveRecord::Migration
  def change
    create_table :complaints_expedient_events do |t|
      t.string :status, default: 'process'
      t.references :expedient, index: true
      t.references :admin, index: true
      t.datetime :start_at
      t.text :justification
      t.timestamps
    end
  end
end
