class CreateAdminHierarchies < ActiveRecord::Migration
  def change
    create_table :admin_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :admin_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "admin_anc_desc_idx"

    add_index :admin_hierarchies, [:descendant_id],
      name: "admin_desc_idx"
  end
end
