class AddSlugFieldToForumsEntriesTable < ActiveRecord::Migration
  def change
    add_column :forums_entries, :slug, :string
    add_index :forums_entries, :slug
  end
end
