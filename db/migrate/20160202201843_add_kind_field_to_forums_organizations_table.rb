class AddKindFieldToForumsOrganizationsTable < ActiveRecord::Migration
  def change
    add_column :forums_organizations, :kind, :string
    add_index :forums_organizations, :kind
  end
end
