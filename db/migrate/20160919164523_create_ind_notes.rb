class CreateIndNotes < ActiveRecord::Migration
  def change
    create_table :ind_notes do |t|
      t.references :category, index: true
      t.string :title
      t.string :slug
      t.text :content
      t.timestamps null: false
    end
  end
end
