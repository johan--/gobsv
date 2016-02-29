class ChangeNameFieldTypeEmploymentsTechnicalCompetencesTable < ActiveRecord::Migration
  def change
    change_column :employments_technical_competences, :name, :text
  end
end
