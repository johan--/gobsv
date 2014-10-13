class AddUserIdFieldToCnsCommentsTable < ActiveRecord::Migration
  def change
    add_column :cns_comments, :user_id, :integer
    add_index :cns_comments, :user_id
  end
end
