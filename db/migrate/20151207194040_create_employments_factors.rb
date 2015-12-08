class CreateEmploymentsFactors < ActiveRecord::Migration
  def change
    create_table :employments_factors do |t|
      t.string :name
      t.integer :factor_score_id, index: true
      t.references :plaza, index: true
      t.decimal :minimum_score, precision: 18, scale: 2
      t.decimal :maximum_score, precision: 18, scale: 2
      t.integer :order
      t.timestamps
    end
  end
end
