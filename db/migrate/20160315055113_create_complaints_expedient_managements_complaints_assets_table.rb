class CreateComplaintsExpedientManagementsComplaintsAssetsTable < ActiveRecord::Migration
  def change
    create_table :complaints_expedient_managements_complaints_assets, id: false do |t|
      t.references :complaints_asset
      t.references :complaints_expedient_management
    end
    add_index :complaints_expedient_managements_complaints_assets, [:complaints_expedient_management_id, :complaints_asset_id], name: 'expedient_management_asset'
    add_index :complaints_expedient_managements_complaints_assets, [:complaints_asset_id, :complaints_expedient_management_id], name: 'asset_expedient_management'
  end
end
