class CreateMsgGroups < ActiveRecord::Migration
  def change
    create_table :msg_groups do |t|
      t.string :name
      t.text :contacts
      t.integer :admin_id
      t.attachment :asset
      t.timestamps null: false
    end
    add_index :msg_groups, :name
    add_index :msg_groups, :admin_id
  end
end
