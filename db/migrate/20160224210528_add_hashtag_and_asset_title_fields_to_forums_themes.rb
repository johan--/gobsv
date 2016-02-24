class AddHashtagAndAssetTitleFieldsToForumsThemes < ActiveRecord::Migration
  def change
    add_column :forums_themes, :asset_title, :string
    add_column :forums_themes, :hashtag, :string
  end
end
