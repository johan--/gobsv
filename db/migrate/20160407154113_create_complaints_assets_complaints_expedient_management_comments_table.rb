class CreateComplaintsAssetsComplaintsExpedientManagementCommentsTable < ActiveRecord::Migration
  def change
    create_table :complaints_assets_expedient_management_comments, id: false do |t|
        t.references :asset
        t.references :expedient_management_comment
    end
    add_index :complaints_assets_expedient_management_comments, [:asset_id, :expedient_management_comment_id], name: 'asset_expedient_management_comment'
    add_index :complaints_assets_expedient_management_comments, [:expedient_management_comment_id, :asset_id], name: 'expedient_management_comment_asset'
  end
end
