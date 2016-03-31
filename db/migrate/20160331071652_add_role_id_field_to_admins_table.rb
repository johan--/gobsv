class AddRoleIdFieldToAdminsTable < ActiveRecord::Migration
  def change
    add_column :admins, :role_id, :integer
    add_index :admins, :role_id
  end
end
