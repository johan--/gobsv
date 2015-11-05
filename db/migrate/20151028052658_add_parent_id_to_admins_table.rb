class AddParentIdToAdminsTable < ActiveRecord::Migration
  def change
    add_column :admins, :parent_id, :integer
  end
end
