class AddSttpIdFieldToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :stpp_id, :integer
  end
end
