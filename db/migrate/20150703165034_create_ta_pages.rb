class CreateTaPages < ActiveRecord::Migration
  def change
    create_table :ta_pages do |t|
      t.integer :priority, null: false, default: 0
      t.string :name
      t.text :content
      t.string :slug
      t.integer :position, null: false, default: 0

      t.timestamps
    end
    add_index :ta_pages, :slug, unique: true
  end
end
