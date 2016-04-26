class CreateEmploymentsPostulantComments < ActiveRecord::Migration
  def change
    create_table :employments_postulant_comments do |t|
      t.boolean :active, default: true
      t.text :comment
      t.date :commented_at
      t.integer :stpp_id
      t.timestamps null: false
    end
  end
end
