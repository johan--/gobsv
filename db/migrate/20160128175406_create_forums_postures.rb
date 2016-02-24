class CreateForumsPostures < ActiveRecord::Migration
  def change
    create_table :forums_postures do |t|
      t.references :theme, index: true
      t.references :organization, index: true
      t.references :actor, index: true
      t.references :entry, index: true
      t.references :admin, index: true
      t.text :quote
      t.date :quoted_at
      t.timestamps
    end
  end
end
