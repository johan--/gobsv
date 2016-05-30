class AddPostulantIdToPostulantCommentsTable < ActiveRecord::Migration
  def change
    add_column :employments_postulant_comments, :postulant_id, :integer
    add_index :employments_postulant_comments, :postulant_id
    rename_column :employments_postulant_comments, :stpp_id, :technical_id
  end
end
