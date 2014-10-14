class AddNameFieldToCnsCommentsTable < ActiveRecord::Migration
  def change
    add_column :cns_comments, :name, :string
  end
end
