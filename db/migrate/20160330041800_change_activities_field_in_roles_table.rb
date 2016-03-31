class ChangeActivitiesFieldInRolesTable < ActiveRecord::Migration
  def up
    remove_column :roles, :activities
    add_column :roles, :activities, :string, array: true, length: 50, using: 'gin', default: '{}'
    add_column :roles, :institution_id, :integer
    add_index :roles, :institution_id
  end

  def down
    remove_column :roles, :institution_id
    remove_column :roles, :activities
    add_column :roles, :activities, :json
  end
end
