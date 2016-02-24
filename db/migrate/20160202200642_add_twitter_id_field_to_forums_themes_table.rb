class AddTwitterIdFieldToForumsThemesTable < ActiveRecord::Migration
  def change
    add_column :forums_themes, :twitter_id, :string
  end
end
