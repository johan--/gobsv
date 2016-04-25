class RenameEmploymentsPlazasTables < ActiveRecord::Migration
  def change
    rename_table :employments_public_competitions, :employments_plazas
    rename_table :employments_specialties, :employments_plaza_specialties
    rename_table :employments_technical_competences, :employments_plaza_skills
    rename_table :employments_experiences, :employments_plaza_experiences
    rename_table :employments_degrees, :employments_plaza_degrees
    rename_table :employments_factors, :employments_plaza_factors
    rename_table :employments_languages, :employments_plaza_languages
    rename_table :employments_contracts, :employments_plaza_contracts
  end
end
