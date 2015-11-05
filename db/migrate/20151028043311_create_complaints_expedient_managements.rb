class CreateComplaintsExpedientManagements < ActiveRecord::Migration
  def change
    create_table :complaints_expedient_managements do |t|
      t.references :expedient, index: true
      t.references :admin, index: true
      t.string :kind
      t.string :status, default: 'new'
      t.text :comment
      t.integer :assigned_ids, array: true, default: []
      t.timestamps
    end
  end
end
