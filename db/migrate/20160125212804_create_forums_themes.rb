class CreateForumsThemes < ActiveRecord::Migration
  def change
    create_table :forums_themes do |t|
      t.boolean :active, default: false
      t.integer :priority, default: 0
      t.string :name
      t.string :video_url
      t.text :description
      t.attachment :cover
      t.boolean :main, default: false
      t.string :slug, index: true
      t.timestamps
    end
  end
end
