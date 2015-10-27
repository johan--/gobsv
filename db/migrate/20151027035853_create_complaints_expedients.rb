class CreateComplaintsExpedients < ActiveRecord::Migration
  def change
    create_table :complaints_expedients do |t|
      t.string :kind
      t.string :contact
      t.string :phone
      t.string :email
      t.text :comment
      t.belongs_to :institution
      t.string :status, default: 'new'
      t.string :correlative
      t.datetime :received_at
      t.datetime :confirmed_at
      t.datetime :admitted_at
      t.timestamps
    end
    add_index :complaints_expedients, :kind
    add_index :complaints_expedients, :contact
    add_index :complaints_expedients, :institution_id
    add_index :complaints_expedients, :status
    add_index :complaints_expedients, :correlative
  end
end
