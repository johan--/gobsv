class CreateComplaintsExpedientManagementComments < ActiveRecord::Migration
  def change
    create_table :complaints_expedient_management_comments do |t|
      t.references :expedient_management
      t.references :admin, index: true
      t.text :comment
      t.timestamps
    end
    add_index :complaints_expedient_management_comments, :expedient_management_id, name: 'comment_expedient_management_id_index'
  end
end
