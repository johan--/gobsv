class AddActiveFieldToEmploymentsApiTable < ActiveRecord::Migration
  def change
    add_column :employments_plaza_contracts, :active, :boolean, default: true
    add_column :employments_plaza_degrees, :active, :boolean, default: true
    add_column :employments_plaza_experiences, :active, :boolean, default: true
    add_column :employments_plaza_languages, :active, :boolean, default: true
    add_column :employments_plaza_skills, :active, :boolean, default: true
    add_column :employments_plaza_specialties, :active, :boolean, default: true
    add_column :employments_plaza_factors, :active, :boolean, default: true
    add_column :employments_areas, :active, :boolean, default: true
  end
end
