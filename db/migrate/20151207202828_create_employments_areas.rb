class CreateEmploymentsAreas < ActiveRecord::Migration
  def change
    create_table :employments_areas do |t|
      t.integer :factor_score_id, index: true
      t.string :name
      t.integer :order
      t.decimal :score, precision: 18, scale: 2
      t.timestamps
    end
  end
end
