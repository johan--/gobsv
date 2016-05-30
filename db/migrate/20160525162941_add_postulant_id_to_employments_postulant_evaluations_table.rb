class AddPostulantIdToEmploymentsPostulantEvaluationsTable < ActiveRecord::Migration
  def change
    add_column :employments_postulant_evaluations, :postulant_id, :integer
    add_index :employments_postulant_evaluations, :postulant_id
  end
end
