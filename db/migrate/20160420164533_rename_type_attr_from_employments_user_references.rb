class RenameTypeAttrFromEmploymentsUserReferences < ActiveRecord::Migration
  def change
    rename_column :employments_user_references, :type, :kind
  end
end
