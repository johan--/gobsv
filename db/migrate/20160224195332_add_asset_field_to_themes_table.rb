class AddAssetFieldToThemesTable < ActiveRecord::Migration
  def change
    add_attachment :forums_themes, :asset
    add_column :forums_themes, :asset_downloads, :integer, default: 0
  end
end
