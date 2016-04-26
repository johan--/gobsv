class CreateEmploymentsPostulantEvaluations < ActiveRecord::Migration
  def change
    create_table :employments_postulant_evaluations do |t|
      t.boolean :active, default: true
      t.integer :postulant_skill_id
      t.integer :configuration_id
      t.integer :factor_id
      t.text :name
      t.float :weight
      t.float :calification
      t.float :assigned_score
      t.float :obtained_score
      t.integer :created_user
      t.timestamp :created_date
      t.integer :updated_user
      t.timestamp :updated_date
      t.timestamps null: false
    end
  end
end
