class CreateForumsEntries < ActiveRecord::Migration
  def change
    create_table :forums_entries do |t|
      t.string :kind, index: true
      t.references :theme, index: true
      t.references :organization, index: true
      t.references :actor, index: true
      t.string :title
      t.text :description
      t.string :url
      t.date :entry_at
      t.attachment :asset
      t.references :admin, index: true
      t.timestamps
    end
  end
end
