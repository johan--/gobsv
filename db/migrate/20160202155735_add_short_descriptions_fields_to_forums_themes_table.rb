class AddShortDescriptionsFieldsToForumsThemesTable < ActiveRecord::Migration
  def change
    add_column :forums_themes, :actors_description, :text
    add_column :forums_themes, :citizens_description, :text
    add_column :forums_themes, :historical_description, :text
  end
end
