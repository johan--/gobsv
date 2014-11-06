class AddUserIpToCnsCommentsTable < ActiveRecord::Migration
  def change
    add_column :cns_comments, :user_ip, :string
  end
end
