class AddResponseCodeFieldToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :response_code, :integer
  end
end
